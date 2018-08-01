
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
  gets.chomp
end

def invalid_command
  puts "Please enter a valid command"
end


def prompt_for_keyword
  puts "Please enter a product keyword"
end

def get_product_keyword
  answer = gets.chomp
end

def prompt_for_specific
 puts "please select item number"
end


def get_item_number
  answer = gets.chomp.to_i
end

def prompt_for_quantity
  puts "Please select the quantity"
end

def get_quantity_num
  answer= gets.chomp.to_i
end



def find_products
  keyword=get_product_keyword
end

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

def show_invoice
  puts $invoice
end

def continue_shopping
  puts "Would you like to keep shopping?"
end 

def get_results_from_api(cust_input_word)
  api_info = RestClient.get("http://api.walmartlabs.com/v1/search?query=#{cust_input_word}&format=json&apiKey=7sdwmrs9mhx2zg7sjq3arbqu")
  inventory_info = JSON.parse(api_info)
   inventory_info["items"].map do |product_hash|
    hash = {}
    hash[:name] = product_hash["name"]
    hash[:sale_price] = product_hash["salePrice"]
    hash
   end
end


   def results_menu(cust_input_word)
    results = get_results_from_api(cust_input_word)
    i=1
      results.each do |item|
        puts "#{i}. #{item[:name]} (price: $#{item[:sale_price]})"
        i+=1
      end
    end

    def select_result_and_quantity(cust_input_word, cust_input_number, cust_input_quantity)
      results = get_results_from_api(cust_input_word)
       index = cust_input_number -= 1
       $cart << results[index][:name]
      $cart_price << (results[index][:sale_price]* cust_input_quantity).round(2)
      results[index]
    end

    def add_cart
     $cart_price.reduce(:+).round(2)
    end


    def invoice
    $invoice = $cart.zip $cart_price
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


def return_results
prompt_for_keyword
answer = get_product_keyword
results_menu(answer)
prompt_for_specific
item_number = get_item_number
prompt_for_quantity
 quantity= get_quantity_num
select_result_and_quantity(answer,item_number, quantity)
end
