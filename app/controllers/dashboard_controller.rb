class DashboardController < ApplicationController
	def index
		pie_chart 
		render :action => 'dashboard.html.erb'
	end	
	def pie_chart
       data_table = GoogleVisualr::DataTable.new
       data_table.new_column('string', 'Idea'   )
       data_table.new_column('date'  , 'Date'    )
       data_table.new_column('number', 'number of votes'   )
       data_table.new_column('number', 'idea number')
       opts   = { :width => 600, :height => 300 }
       @chart = GoogleVisualr::Interactive::MotionChart.new(data_table, opts)
 
    end
end