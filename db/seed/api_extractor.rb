require 'rest-client'
require 'json'
require 'pry'

$cart= []
$cart_price = []
$invoice = []

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
       index = cust_input_number -1
       $cart << results[index][:name]
      $cart_price << (results[index][:sale_price]* cust_input_quantity).round(2)
      results[index]
    end

    def add_cart
     $cart_price.reduce(:+).round(2)
    end


    def invoice
    $invoice = $cart.zip $cart_price
    puts $invoice
  end
def show_invoice
   puts $invoice
end
