module ForecastrequestsHelper

def add_datepicker(name)
    img = image_tag('datepickerpopup.gif', :alt => "DatePicker")
	link_to img, "#", :onclick => "displayDatePicker('forecastrequest[#{name}]',this,'ymd','-');"
end#def

def injixo_logo
    img = image_tag('injixo.jpg')
	link_to img, "http://www.injixo.com"
end#def

end
