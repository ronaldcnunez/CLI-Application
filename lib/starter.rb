
require 'rest-client'
require 'json'
require 'pry'

$cart= []
$cart_price = []
$invoice = []

def welcome
  puts "Welcome to BriRon's Discount Palace!"
end

def prompt_customer_name
  puts "Please enter your full name."
end

def get_customer_name
  puts "Please enter your full name."
  gets.chomp
end

def invalid_command
  puts "Please enter a valid command"
end

def find_products
  puts "Please enter a product keyword"
  keyword=gets.chomp
  puts "The rest of this feature has not been implemented yet. Stay tuned."
end

def offer_prev_cust_next_choice
  puts "Would you like to shop or end your session?"
  puts "Type 's' to shop or 'e' to end session"
  answer=gets.chomp
  if answer=='s'
  find_products
else
  puts "Thanks for stopping by!"
end

end

  def find_or_create_customer
    name = get_customer_name #asks for full name, assigns input to variable
    customer = Customer.find_by(name: name) #assigns search to variable
    if customer == nil
      customer = Customer.create(name: name) # creates customer if not found
      puts "We've created a customer account for you. Let's go shopping!!"
      find_products
    else
      puts "We're glad to see you back!"
      puts "Would you like to review past invoices or go shopping?"
      puts "Type 'p' for previous invoices or 's' to shop."
    end
      direction=gets.chomp
      if direction == "p"
        invoice_num=1
        customer.invoices.each do |inv|
          puts "Invoice ##{invoice_num}. Name: #{inv.customer.name}, Product: #{inv.product.name}, Price: $#{inv.product.price} Quantity: #{inv.quantity}"
          invoice_num+=1
      end
      elsif direction == "s"
        find_products
      else
        invalid_command
        find_products
    end
    offer_prev_cust_next_choice
end

def checkout
invoice
show_invoice
end


def return_results
prompt_for_keyword
answer = get_user_input
results_menu(answer)
prompt_for_specific
item_number = get_item_number
prompt_for_quantity
 quantity= get_quantity_num
select_result_and_quantity(answer,item_number, quantity)
add_cart
answer = get_user_input
if answer == "y"
  adds_to_cart
  show_invoice && continue_shopping
elsif answer == "n"
  adds_to_cart
  invoice
  exit1
else
    invalid_command
end
end
