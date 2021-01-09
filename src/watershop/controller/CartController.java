package watershop.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import watershop.entity.Customer;
import watershop.entity.Order;
import watershop.entity.OrderDetail;
import watershop.entity.Product;


@Transactional
@Controller
@RequestMapping("/")
public class CartController {
	@Autowired
	SessionFactory factory;
	
	@RequestMapping(value="addtocart/{productId}", method=RequestMethod.GET)
	public String adToCart(ModelMap model, @PathVariable("productId") int id, HttpSession session) {
		Session ss = factory.getCurrentSession();
		Product product = (Product) ss.get(Product.class, id);
			
		Order order = (Order) session.getAttribute("cart");
		if(order == null) {
			order = new Order();
			order.setOrderDetails(new ArrayList<OrderDetail>());
		}
		
		// The product doesn't exist in the shopping cart
		int index = isExists(id, session);
		if(index == -1) {
			OrderDetail orderDetail = new OrderDetail();
			orderDetail.setOrder(order); // set orderId
			orderDetail.setProduct(product); // set productId
			orderDetail.setUnitPrice(product.getUnitPrice());
			orderDetail.setQuantity(1);
			order.getOrderDetails().add(orderDetail);
		} else {
			if(order.getOrderDetails().get(index).getQuantity() < product.getQuantity()) {
				int quantity = order.getOrderDetails().get(index).getQuantity() + 1;
				order.getOrderDetails().get(index).setQuantity(quantity);
			}
//			else {
//				model.addAttribute("message", "Trong kho chỉ còn " + product.getQuantity() + " sản phẩm bằng với số lượng bạn đã thêm vào giỏ hàng!");
//			}
		}		
		
		session.setAttribute("cart", order);
		session.setAttribute("numOfItems", getNumOfItemsInCart(session));

		return "redirect:/index.htm";
	}
	
	@RequestMapping(value="buynow/{productId}", method=RequestMethod.GET)
	public String buyNow(@PathVariable("productId") int id, HttpSession session) {
		Session ss = factory.getCurrentSession();
		Product product = (Product) ss.get(Product.class, id);
		Order order = (Order) session.getAttribute("cart");
		if(order == null) {
			order = new Order();
			order.setOrderDetails(new ArrayList<OrderDetail>());
		}
		
		// The product doesn't exist in the shopping cart
		int index = isExists(id, session);
		if(index == -1) {
			OrderDetail orderDetail = new OrderDetail();
			orderDetail.setOrder(order); // set orderId
			orderDetail.setProduct(product); // set productId
			orderDetail.setUnitPrice(product.getUnitPrice());
			orderDetail.setQuantity(1);
			order.getOrderDetails().add(orderDetail);
		} else {
			int quantity = order.getOrderDetails().get(index).getQuantity() + 1;
			order.getOrderDetails().get(index).setQuantity(quantity);
		}		
		
		session.setAttribute("cart", order);
//		session.setAttribute("numOfItems", getNumOfItemsInCart(order));
		session.setAttribute("numOfItems", getNumOfItemsInCart(session));

		return "redirect:/cart.htm";
	}
	
	@RequestMapping(value="addbuycartfromdetail/{id}", params="btnAddToCart", method=RequestMethod.POST)
	public String addToCartFromProductDetail(@RequestParam("quantity") int quantity, @PathVariable("id") int id, HttpSession session) {
		Session ss = factory.getCurrentSession();
		Product product = (Product) ss.get(Product.class, id);
		
		Order order = (Order) session.getAttribute("cart");
		if(order == null) {
			order = new Order();
			order.setOrderDetails(new ArrayList<OrderDetail>());
		}
		
		// The product doesn't exist in the shopping cart
		int index = isExists(id, session);
		if(index == -1) {
			OrderDetail orderDetail = new OrderDetail();
			orderDetail.setOrder(order); // set orderId
			orderDetail.setProduct(product); // set productId
			orderDetail.setUnitPrice(product.getUnitPrice());
			orderDetail.setQuantity(quantity);
			order.getOrderDetails().add(orderDetail);
		} else {
			int quantityTotal = order.getOrderDetails().get(index).getQuantity() + quantity;
			order.getOrderDetails().get(index).setQuantity(quantityTotal);
		}
		
		session.setAttribute("cart", order);
//		session.setAttribute("numOfItems", getNumOfItemsInCart(order));
		session.setAttribute("numOfItems", getNumOfItemsInCart(session));

		return "redirect:/detail/"+product.getId() + ".htm";
	}
	
	@RequestMapping(value="addbuycartfromdetail/{id}", params="btnBuyNow", method=RequestMethod.POST)
	public String buyNowFromProductDetail(@RequestParam("quantity") int quantity, @PathVariable("id") int id, HttpSession session) {
		Session ss = factory.getCurrentSession();
		Product product = (Product) ss.get(Product.class, id);
		Order order = (Order) session.getAttribute("cart");
		if(order == null) {
			order = new Order();
			order.setOrderDetails(new ArrayList<OrderDetail>());
		}
		
		// The product doesn't exist in the shopping cart
		int index = isExists(id, session);
		if(index == -1) {
			OrderDetail orderDetail = new OrderDetail();
			orderDetail.setOrder(order); // set orderId
			orderDetail.setProduct(product); // set productId
			orderDetail.setUnitPrice(product.getUnitPrice()); // xem lai la unitPrice hay totalPrice
			orderDetail.setQuantity(quantity);
			order.getOrderDetails().add(orderDetail);
		} else {
			int quantityTotal = order.getOrderDetails().get(index).getQuantity() + quantity;
			order.getOrderDetails().get(index).setQuantity(quantityTotal);
		}
		
		session.setAttribute("cart", order);
//		session.setAttribute("numOfItems", getNumOfItemsInCart(order));
		session.setAttribute("numOfItems", getNumOfItemsInCart(session));

		return "redirect:/cart.htm";
	}
	
	@RequestMapping(value="minusquantityitem/{productId}", method=RequestMethod.GET)
	public String minusQuantity(@PathVariable("productId") int productId, HttpSession session) {
		Order order = (Order) session.getAttribute("cart");
		List<OrderDetail> orderDetails = order.getOrderDetails();
		int index = isExists(productId, session);
		int quantity = orderDetails.get(index).getQuantity();
		if(quantity > 1) 
			quantity--;
		orderDetails.get(index).setQuantity(quantity);
		order.setOrderDetails(orderDetails);
		session.setAttribute("cart", order);
		session.setAttribute("numOfItems", getNumOfItemsInCart(session));
		return "redirect:/cart.htm";
	}
	
	@RequestMapping(value="plusquantityitem/{productId}", method=RequestMethod.GET)
	public String plusQuantity(@PathVariable("productId") int productId, HttpSession session) {
		Order order = (Order) session.getAttribute("cart");
		List<OrderDetail> orderDetails = order.getOrderDetails();
		int index = isExists(productId, session);
		int quantity = orderDetails.get(index).getQuantity();
		Session ss = factory.getCurrentSession();
		Product product = (Product) ss.get(Product.class, productId);
		if(quantity < product.getQuantity())
			quantity++;
		orderDetails.get(index).setQuantity(quantity);
		order.setOrderDetails(orderDetails);
		session.setAttribute("cart", order);
		session.setAttribute("numOfItems", getNumOfItemsInCart(session));
		return "redirect:/cart.htm";
	}
	
	@RequestMapping(value="cart", method=RequestMethod.GET)
	public String cart(HttpSession session) {
		Order order = (Order) session.getAttribute("cart");
		if(order != null) {
			List<OrderDetail> orderDetails = order.getOrderDetails();
			int amount = 0;
			for(OrderDetail orderDetail : orderDetails) {
				amount += orderDetail.getQuantity() * orderDetail.getUnitPrice();
			}
			order.setAmount(amount);
			session.setAttribute("cart", order);
		}
		return "cart";
	}
	
	@RequestMapping(value="removeitem/{orderDetailId}", method=RequestMethod.GET)
	public String removeItem(@PathVariable("orderDetailId") int orderDetailId, HttpSession session) {
		Order order = (Order) session.getAttribute("cart");
		List<OrderDetail> orderDetails = order.getOrderDetails();
		
		int index = isExists(orderDetailId, session);
		orderDetails.remove(index);
		order.setOrderDetails(orderDetails);
//		session.setAttribute("numOfItems", getNumOfItemsInCart(order));
		session.setAttribute("numOfItems", getNumOfItemsInCart(session));

		session.setAttribute("cart", order);
		return "redirect:/cart.htm";
	}
	
	@RequestMapping(value="checkout")
	public String checkout(HttpSession session) {
		Session ss = factory.openSession();
		
		String userId = (String) session.getAttribute("username");
		Customer customer = (Customer) ss.get(Customer.class, userId);
		
		//List<Order> orders = new ArrayList<Order>();
		Order order = (Order) session.getAttribute("cart");
		//orders.add(order);//
		//customer.setOrders(orders);//
		order.setCustomer(customer);//
		
		
		return "checkout";
	}
	
	@RequestMapping(value="order")
	public String order(ModelMap model, HttpSession session) {
		Order order = (Order) session.getAttribute("cart");

		Session ss = factory.openSession();
		Transaction t = ss.beginTransaction();
		
		try {
			order.setOrderDate(new Date());
			ss.save(order);
			t.commit();
		} catch (Exception e) {
			t.rollback();
		} finally {
			ss.close();
		}

		List<OrderDetail> list = order.getOrderDetails();
		for(OrderDetail od : list) {
			Session ss2 = factory.openSession();
			Transaction t2 = ss2.beginTransaction();
			try {
				ss2.save(od);
				t2.commit();
			} catch (Exception e) {
				t2.rollback();
			} finally {
				ss2.close();
			}
			
			Session ss3 = factory.openSession();
			Transaction t3 = ss3.beginTransaction();
			Product product = od.getProduct();
			int quantity = product.getQuantity() - od.getQuantity();
			product.setQuantity(quantity);
			try {
				ss3.update(product);
				t3.commit();
			} catch (Exception e) {
				t3.rollback();
			} finally {
				ss3.close();
			}
		}
		model.addAttribute("orderId", order.getId());
		session.removeAttribute("cart");		
		session.setAttribute("numOfItems", getNumOfItemsInCart(session));
		return "thankyou";
	}
	
	
	private int isExists(int id, HttpSession session) {
		if(session.getAttribute("cart") != null) {
			Order order = (Order) session.getAttribute("cart");
			List<OrderDetail> orderDetails = order.getOrderDetails();
			for(int i = 0; i < orderDetails.size(); i++)
				if(id == orderDetails.get(i).getProduct().getId()) {
					return i;
				}
		}
		return -1;
	}
	
//	private int getNumOfItemsInCart(Order order) {
//		int sum = 0;
//		if(order != null) {
//			List<OrderDetail> orderDetails = order.getOrderDetails();
//			for(OrderDetail orderDetail : orderDetails)
//				sum += orderDetail.getQuantity();
//		}
//		
//		return sum;
//	}
	
	private int getNumOfItemsInCart(HttpSession session) {
		int sum = 0;
		Order order = (Order) session.getAttribute("cart");
		if(order != null) {
			List<OrderDetail> orderDetails = order.getOrderDetails();
			for(OrderDetail orderDetail : orderDetails)
				sum += orderDetail.getQuantity();
		}
		
		return sum;
	}
}
