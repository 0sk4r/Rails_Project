class Report < ApplicationRecord
  belongs_to :reporting_user, class_name: 'Author'
  belongs_to :post
end
