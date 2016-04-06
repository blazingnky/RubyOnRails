class TimeConstraint
	def matches?(request)
		current = Time.now
		current.hour >= 9 && currnet.hour < 18
	end
end