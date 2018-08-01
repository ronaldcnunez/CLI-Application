require_all 'lib'


def welcome
  puts "Welcome to BriRon's Discount Palace!"
end

def prompt_customer_name
  puts "Please enter your full name."
end

def get_customer_name
  gets.chomp
end

def invalid_command
  puts "Please enter a valid command"
end


def prompt_for_keyword
  puts "Please enter a product keyword"
end

def get_product_keyword
  gets.chomp
end

# def find_products
#   keyword=get_product_keyword
# end

def search_and_display_items
  prompt_for_keyword
  find_products
end

def previous_cust_direction
  puts "Would you like to review past invoices or go shopping?"
  puts "Type 'p' for previous invoices or 's' to shop."
end

def get_prev_cust_response
  gets.chomp
end

def react_to_prev_cust_direction
  direction=get_prev_cust_response
  if direction == "p"
    Invoice.select {|ind_invoice| ind_invoice.customer_id == self.id}
  elsif direction == "s"
    prompt_for_keyword
  else
    invalid_command
    prompt_for_keyword
  end
end

def prev_cust_pack
  previous_cust_direction
  react_to_prev_cust_direction
end

def find_or_create_customer
  welcome
  prompt_customer_name
  name = get_customer_name
  is_customer = Customer.find_by(name: name)
  if is_customer == nil
    Customer.create(name: name)
    puts "We've created a customer account for you. Let's go shopping!!"
    search_and_display_items
  else
    puts "We're glad to see you back!"
    prev_cust_pack
  end
end
