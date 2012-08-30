require 'redcarpet'

class Gfm2Confluence
	def self.convert(text)
		markdown = Redcarpet::Markdown.new(Gfm2Confluence::Converter,
								:autolink => true, :fenced_code_blocks => true, 
								:hard_wrap => true, :strikethrough => true, 
								:superscript => true, :no_intra_emphasis => true)
		result = markdown.render(text)
	end
end

require 'gfm2confluence/converter.rb'