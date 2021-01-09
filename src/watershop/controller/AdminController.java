package watershop.controller;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;

import javax.servlet.ServletContext;

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
import org.springframework.web.multipart.MultipartFile;

import watershop.entity.Order;
import watershop.entity.OrderDetail;
import watershop.entity.Product;

@Transactional
@Controller
@RequestMapping("/admin/")
public class AdminController {
	@Autowired
	ServletContext context;
	@Autowired
	SessionFactory factory;

	@RequestMapping("product")
	public String product(ModelMap model) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Product";
		Query query = session.createQuery(hql);
		List<Product> list = query.list();
		model.addAttribute("products", list);
		return "admin/product";
	}

	@RequestMapping(value = "addproduct", method = RequestMethod.GET)
	public String addProduct(ModelMap model) {
		model.addAttribute("product", new Product());
		return "admin/addproduct";
	}

	@RequestMapping(value = "addproduct", method = RequestMethod.POST)
	public String addProduct(ModelMap model, @ModelAttribute("product") Product product,
			@RequestParam("photo") MultipartFile photo, BindingResult errors) {

		if (product.getName().trim().length() == 0) {
			errors.rejectValue("name", "product", "Vui lòng nhập tên sản phẩm!");
		}
		if (product.getQuantity() == null) {
			errors.rejectValue("quantity", "product", "Số lượng không hợp lệ!");
		}
		if (product.getUnitPrice() == null) {
			errors.rejectValue("unitPrice", "product", "Đơn giá không hợp lệ!");
		}
		if (product.getSpecification().trim().length() == 0) {
			errors.rejectValue("specification", "product", "Vui lòng nhập quy cách!");
		}
		if (product.getDescription().trim().length() == 0) {
			errors.rejectValue("description", "product", "Vui lòng nhập mô tả sản phẩm!");
		}
		if (product.getAvailable() == null) {
			errors.rejectValue("available", "product", "Vui lòng chọn tình trạng sản phẩm!");
		}
		if (photo.isEmpty()) {
			errors.rejectValue("image", "product", "Vui lòng chọn file!");
		} else {
			String ext = photo.getOriginalFilename().substring(photo.getOriginalFilename().lastIndexOf(".") + 1);
			if (!(ext.equalsIgnoreCase("jpeg") || ext.equalsIgnoreCase("jpg") || ext.equalsIgnoreCase("png"))) {
				errors.rejectValue("image", "product", "File không hợp lệ!");
			}
		}

		if (!errors.hasErrors()) {
			Session ss = factory.openSession();
			Transaction t = ss.beginTransaction();
			try {
				saveFile(photo.getOriginalFilename(), photo);
				product.setImage("resources/images/products/" + photo.getOriginalFilename());
				ss.save(product);
				t.commit();
				model.addAttribute("message", "Thêm sản phẩm thành công!");
				//return "redirect:/admin/addproduct.htm";
			} catch (IOException e) {
				e.printStackTrace();
				t.rollback();				
			} finally {
				ss.close();
			}
		}		
		return "admin/addproduct";
	}
	
	@RequestMapping(value="deleteproduct/{productId}", method=RequestMethod.GET)
	public String deleteProduct(ModelMap model, @PathVariable("productId") int productId) {
		Session ss = factory.openSession();
		Transaction t = ss.beginTransaction();
		Product product = (Product) ss.get(Product.class, productId);
		try {
			ss.delete(product);
			t.commit();
		} catch (Exception e) {
			t.rollback();
		} finally {
			ss.close();
		}
		return "redirect:/admin/product.htm";
	}
	
	@RequestMapping(value="editproduct/{productId}", method=RequestMethod.GET)
	public String editProduct(ModelMap model, @PathVariable("productId") int productId) {
		Session ss = factory.getCurrentSession();
		Product product = (Product) ss.get(Product.class, productId);
		model.addAttribute("product", product);
		
		return "admin/editproduct";
	}
	
	@RequestMapping(value="editproduct", method=RequestMethod.POST)
	public String editProduct(ModelMap model, @ModelAttribute("product") Product product,
			@RequestParam("photo") MultipartFile photo, BindingResult errors) {
		boolean imageValid = false;
		Session sTemp = factory.getCurrentSession();
		Product pTemp = (Product) sTemp.get(Product.class, product.getId());
		product.setImage(pTemp.getImage());
		if (product.getName().trim().length() == 0) {
			errors.rejectValue("name", "product", "Vui lòng nhập tên sản phẩm!");
		}
		if (product.getQuantity() == null) {
			errors.rejectValue("quantity", "product", "Số lượng không hợp lệ!");
		}
		if (product.getUnitPrice() == null) {
			errors.rejectValue("unitPrice", "product", "Đơn giá không hợp lệ!");
		}
		if (product.getSpecification().trim().length() == 0) {
			errors.rejectValue("specification", "product", "Vui lòng nhập quy cách!");
		}
		if (product.getDescription().trim().length() == 0) {
			errors.rejectValue("description", "product", "Vui lòng nhập mô tả sản phẩm!");
		}
		if (product.getAvailable() == null) {
			errors.rejectValue("available", "product", "Vui lòng chọn tình trạng sản phẩm!");
		}
		if (!photo.isEmpty()) {
			String ext = photo.getOriginalFilename().substring(photo.getOriginalFilename().lastIndexOf(".") + 1);
			if (!(ext.equalsIgnoreCase("jpeg") || ext.equalsIgnoreCase("jpg") || ext.equalsIgnoreCase("png"))) {
				errors.rejectValue("image", "product", "File không hợp lệ!");
			} else {
				imageValid = true;
			}
		}

		if (!errors.hasErrors()) {
			Session ss = factory.openSession();
			Transaction t = ss.beginTransaction();
			try {
				if(imageValid) {
					saveFile(photo.getOriginalFilename(), photo);
					product.setImage("resources/images/products/" + photo.getOriginalFilename());
				}
				ss.update(product);
				t.commit();
				model.addAttribute("message", "Sửa thông tin sản phẩm thành công!");
				//return "redirect:/admin/product.htm";
			} catch (IOException e) {
				e.printStackTrace();
				t.rollback();
			} finally {
				ss.close();
			}
		}		
		return "admin/editproduct";
	}

	public static void saveFile(String fileName, MultipartFile multipartFile) throws IOException {
		Path uploadPath = Paths
				.get("C:\\Users\\nguyenkt\\eclipse-workspace\\WaterShop\\WebContent\\resources\\images\\products");

		if (!Files.exists(uploadPath)) {
			Files.createDirectories(uploadPath);
		}

		try (InputStream inputStream = multipartFile.getInputStream()) {
			Path filePath = uploadPath.resolve(fileName);
			Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
		} catch (IOException ioe) {
			throw new IOException("Could not save image file: " + fileName, ioe);
		}
	}
	
	@RequestMapping(value="order", method = RequestMethod.GET)
	public String showOrders(ModelMap model) {
		Session ss = factory.getCurrentSession();
		String hql = "FROM Order";
		Query query = ss.createQuery(hql);
		List<Order> list = query.list();
		model.addAttribute("orders", list);
		return "admin/order";
	}
	
	@RequestMapping(value="order/detail/{orderId}", method = RequestMethod.GET)
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
		return "admin/orderdetail";
	}
	
	@RequestMapping("customer")
	public String customer(ModelMap model) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Customer";
		Query query = session.createQuery(hql);
		List<Product> list = query.list();
		model.addAttribute("customers", list);
		return "admin/customer";
	}
	
	@RequestMapping(value="customerorder/{customerId}", method = RequestMethod.GET)
	public String showCustomerOrders(ModelMap model, @PathVariable("customerId") String customerId) {
		Session ss = factory.getCurrentSession();
		String hql = "FROM Order o WHERE o.customer.id=:cid";
		Query query = ss.createQuery(hql);
		query.setParameter("cid", customerId);
		List<Order> list = query.list();
		model.addAttribute("ordercustomers", list);
		return "admin/customerorder";
	}
	
}
