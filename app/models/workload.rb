class Workload < ActiveRecord::Base
  attr_accessible :wl, :dt
  
  validates(:dt, :format => { dt.getutc == dt })
  
  belongs_to :Forecastrequest
  
end