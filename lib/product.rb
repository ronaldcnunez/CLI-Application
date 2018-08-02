class Product < ActiveRecord::Base
  has_many :customers, through: :invoices




end #end of class
