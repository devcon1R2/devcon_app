# == Schema Information
#
# Table name: forecastrequests
#
#  id         :integer         not null, primary key
#  email      :string(255)
#  startdate  :datetime
#  enddate    :datetime
#  interval   :integer
#  data       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Forecastrequest < ActiveRecord::Base

  attr_accessible :email, :startdate, :enddate, :interval, :data
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  
  validates :email, :presence => true,
				    :format => { :with => email_regex },
            :uniqueness => { :case_sensitive => false }
            
  validates :startdate, :presence => true
  
  validates :enddate, :presence => true
           
  validates :interval, :presence => true
  
  validates :data, :presence => true
  
  def make_hash
    dataarray = self.data.split("\n")
    datahash = {}
    dataarray.each do |workload|
      wl = workload.split(',')
      datahash[wl[0]] = wl[1]
    end
    { :startdate  => self.startdate.to_s(:db),
      :enddate    => self.enddate.to_s(:db),
      :interval   => self.interval.to_s,
      :wlc        => datahash }
  end

end
