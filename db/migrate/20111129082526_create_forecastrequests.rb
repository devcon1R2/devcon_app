class CreateForecastrequests < ActiveRecord::Migration
  def self.up
    create_table :forecastrequests do |t|
      t.string :email
      t.datetime :startdate
      t.datetime :enddate
      t.integer :interval
      t.string :data

      t.timestamps
    end
  end

  def self.down
    drop_table :forecastrequests
  end
end
