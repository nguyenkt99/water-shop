package watershop.controller;

import java.io.Serializable;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import watershop.bean.Mailer;
import watershop.entity.Customer;
import watershop.entity.Order;
import watershop.entity.OrderDetail;
import watershop.entity.Product;

@Transactional
@Controller
@RequestMapping("/")
public class HomeController {
	@Autowired
	SessionFactory factory;
	
	@Autowired
	HttpSession session;
	
	@Autowired
	Mailer mailer;
	
	@Autowired
	HttpServletRequest request;
	
	@RequestMapping("index")
	public String index(ModelMap model) {
		if(session.getAttribute("username") != null) {
			Session ss = factory.getCurrentSession();
			Customer customer = (Customer) ss.get(Customer.class, (String) session.getAttribute("username"));
			if(customer.getAdmin()) {
				session.removeAttribute("username");;
			}	
		}
		
		Session ss = factory.getCurrentSession();
		String hql = "FROM Product";
		Query query = ss.createQuery(hql);
		List<Product> list = query.list();
		model.addAttribute("products", list);
		
		Order order = (Order) session.getAttribute("cart");
		session.setAttribute("numOfItems", getNumOfItemsInCart(order));
		return "index";
	}
	
	@RequestMapping("admin/index")
	public String index() {
		if(session.getAttribute("username") != null) {
			Session ss = factory.getCurrentSession();
			Customer customer = (Customer) ss.get(Customer.class, (String) session.getAttribute("username"));
			if(customer.getAdmin()) {
				return "admin/index";
			}	
		}
		return "redirect:/logout.htm";
	}
	
	@RequestMapping(value="login", method=RequestMethod.GET)
	public String login() {
		return "login";
	}
	
	@RequestMapping(value="login", method=RequestMethod.POST)
	public String login(@RequestParam("username") String username, @RequestParam("password") String password, ModelMap model) {
		// ID PW blank
		if(username.isEmpty() || password.isEmpty()) {
			model.addAttribute("message", "Vui lòng nhập tài khoản mật khẩu");
			return "login";
		}

		Session ss = factory.getCurrentSession();
		String hql = "FROM Customer c WHERE c.id=:username AND c.password=:password";
		Query query = ss.createQuery(hql);
		query.setParameter("username", username);
		query.setParameter("password", password);
		Customer customer = (Customer) query.uniqueResult();
		
		if(customer != null) {
			if(customer.getActivated()) {
				session.setAttribute("username", username);
				if(customer.getAdmin()) {
					return "redirect:/admin/index.htm";
				}
				return "redirect:/index.htm";
			} else {
				model.addAttribute("message", "Vui lòng kiểm tra hộp thư " + customer.getEmail() + " để kích hoạt tài khoản!");
				return "login";
			}
		} else {
			model.addAttribute("message", "Sai tài khoản hoặc mật khẩu!");
			return "login";
		}
	}
	
	@RequestMapping(value={"logout", "admin/logout"}, method=RequestMethod.GET)
	public String logout() {
		session.removeAttribute("username");
		session.removeAttribute("cart");
		session.removeAttribute("numOfItems");
		return "redirect:/login.htm";
	}
	
	@RequestMapping(value="register", method=RequestMethod.GET)
	public String register(ModelMap model) {
		model.addAttribute("customer", new Customer());
		return "register";
	}
	
	@RequestMapping(value="register", method=RequestMethod.POST)
	public String register(ModelMap model, @ModelAttribute("customer") Customer customer, BindingResult errors) {
		
		Session ssTemp = factory.getCurrentSession();
		String hqlTemp = "FROM Customer c WHERE c.id=:username";
		Query queryTemp = ssTemp.createQuery(hqlTemp);
		queryTemp.setParameter("username", customer.getId());
		Customer customerTemp = (Customer) queryTemp.uniqueResult();
		
		if(customerTemp != null) {
			errors.rejectValue("id", "customer", "Tài khoản bị trùng! Vui lòng chọn tên tài khoản khác");
		}
		if(customer.getId().trim().length() == 0) {
			errors.rejectValue("id", "customer", "Vui lòng nhập tài khoản");
		}
		if(customer.getPassword().trim().length() == 0) {
			errors.rejectValue("password", "customer", "Vui lòng nhập mật khẩu");
		}
		if(customer.getFullname().trim().length() == 0) {
			errors.rejectValue("fullname", "customer", "Vui lòng nhập họ tên");
		}
		if(customer.getAddress().trim().length() == 0) {
			errors.rejectValue("address", "customer", "Vui lòng nhập địa chỉ");
		}
		if(customer.getEmail().trim().length() == 0) {
			errors.rejectValue("email", "customer", "Vui lòng nhập email");
		}
		if(customer.getPhonenumber().trim().length() == 0) {
			errors.rejectValue("phonenumber", "customer", "Vui lòng nhập số điện thoại");
		}
		
		
		if(!errors.hasErrors()) {
			Session ss = factory.openSession();
			Transaction t = ss.beginTransaction();
			try {
				customer.setActivated(false);
				customer.setAdmin(false);
				ss.save(customer);
				t.commit();
				
				String from = "demo1211141@gmail.com";
				String to = customer.getEmail();
				String subject = "Xác nhận tạo tài khoản";
				String url = request.getRequestURL().toString().replace("register", "activate/" + customer.getId());
				
				String body = "Nhấn vào <a href='" + url + "'>đây</a> để hoàn tất đăng kí.";
				mailer.send(from, to, subject, body);
				model.addAttribute("message", "Vui lòng kiểm tra thư " + customer.getEmail() + " để kích hoạt tài khoản!");
			} catch (Exception e) {
				e.printStackTrace();
				t.rollback();
			} finally {
				ss.close();
			}
			
		} 
		
		return "register";
	}
	
	@RequestMapping(value="activate/{customerId}", method=RequestMethod.GET)
	public String activateCustomer(ModelMap model, @PathVariable("customerId") String customerId) {
		Session ss = factory.getCurrentSession();
		Customer customer = (Customer) ss.get(Customer.class, customerId);
		customer.setActivated(true);
		ss.update(customer);
		session.setAttribute("username", customerId);
			
		return "redirect:/index.htm";
	}
	
	@RequestMapping(value="editprofile/{customerId}", method=RequestMethod.GET)
	public String editProfile(ModelMap model, @PathVariable("customerId") String customerId) {
		
		Session ss = factory.getCurrentSession();
		Customer customer = (Customer) ss.get(Customer.class, customerId);
		model.addAttribute("customer", customer);
		return "editprofile";
	}
	
	@RequestMapping(value="editprofile", method=RequestMethod.POST)
	public String editProfile(ModelMap model, @ModelAttribute("customer") Customer customer, BindingResult errors) {
		if(customer.getPassword().trim().length() == 0) {
			errors.rejectValue("password", "customer", "Vui lòng nhập mật khẩu");
		}
		if(customer.getFullname().trim().length() == 0) {
			errors.rejectValue("fullname", "customer", "Vui lòng nhập họ tên");
		}
		if(customer.getAddress().trim().length() == 0) {
			errors.rejectValue("address", "customer", "Vui lòng nhập địa chỉ");
		}
		if(customer.getEmail().trim().length() == 0) {
			errors.rejectValue("email", "customer", "Vui lòng nhập email");
		}
		if(customer.getPhonenumber().trim().length() == 0) {
			errors.rejectValue("phonenumber", "customer", "Vui lòng nhập số điện thoại");
		}
		
		if(!errors.hasErrors()) {
			Session ss = factory.openSession();
			Transaction t = ss.beginTransaction();
			try {
				customer.setActivated(true);
				customer.setAdmin(false);
				ss.update(customer);
				t.commit();
				model.addAttribute("message", "Chỉnh sửa thông tin hoàn tất");
			} catch (Exception e) {
				t.rollback();
			} finally {
				ss.close();
			}			
		}
		return "editprofile";
	}
	
	@RequestMapping(value="detail/{productId}", method=RequestMethod.GET)
	public String getProductDetail(ModelMap model, @PathVariable("productId") int id) {
		Session ss = factory.getCurrentSession();
		Product product = (Product) ss.get(Product.class, id);
		model.addAttribute("product", product);
		
		Order order = (Order) session.getAttribute("cart");
		session.setAttribute("numOfItems", getNumOfItemsInCart(order));
		return "detail";
	}
	
	
	@RequestMapping(value="orderlist/{customerId}", method = RequestMethod.GET)
	public String showCustomerOrders(ModelMap model, @PathVariable("customerId") String customerId) {
		Session ss = factory.getCurrentSession();
		String hql = "FROM Order o WHERE o.customer.id=:cid";
		Query query = ss.createQuery(hql);
		query.setParameter("cid", customerId);
		List<Order> list = query.list();
		model.addAttribute("ordercustomers", list);
		return "orderlist";
	}
	
	@RequestMapping(value="orderdetail/{orderId}", method = RequestMethod.GET)
	public String showOrderDetail(ModelMap model, @PathVariable("orderId") int orderId) {
		Session ss = factory.getCurrentSession();
		String hql = "FROM OrderDetail od WHERE od.order.id=:oid";
		Query query = ss.createQuery(hql);
		query.setParameter("oid", orderId);
		List<OrderDetail> list = query.list();
		model.addAttribute("orderId", list.get(0).getOrder().getId());
		model.addAttribute("orderdetails", list);
		
		// lấy thông tin địa chỉ người mua + tổng thanh toán
		Session ss2 = factory.getCurrentSession();
		String hql2 = "FROM Order o WHERE o.id=:oid";
		Query query2 = ss2.createQuery(hql2);
		query2.setParameter("oid", orderId);
		List<Order> list2 = query2.list();
		Order order = list2.get(0);
		model.addAttribute("order", order); 
		return "orderdetail";
	}
	
	private int getNumOfItemsInCart(Order order) {
		int sum = 0;
		if(order != null) {
			List<OrderDetail> orderDetails = order.getOrderDetails();
			for(OrderDetail orderDetail : orderDetails)
				sum += orderDetail.getQuantity();
		}
		
		return sum;
	}
}
