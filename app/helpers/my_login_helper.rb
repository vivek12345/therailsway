module MyLoginHelper
	def my_test(page_title)
		base_title="The Rails Way"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end
	
end
