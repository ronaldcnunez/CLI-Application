class Customer < ActiveRecord::Base
has_many :products, through: :invoices





end #end of class
