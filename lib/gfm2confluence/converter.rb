# -*- coding: utf-8 -*-
# The class which extends Redcarpet::Render::Base and converts the text

require 'redcarpet'

#TODO: parse <pre> tags for {code} tags
#TODO: parse <p> tags to paragraphs
#TODO: parse <iframe> tags
class Gfm2Confluence::Converter < Redcarpet::Render::Base
	def block_code(code, language)
		"{code}\n#{code}{code}\n\n"
	end

	def block_quote(quote)
		"{quote}\n#{quote}{quote}\n"
	end

	def block_html(raw_html)
		#TODO: try to parse the html body and replce tags where possible
		raw_html
	end

	def header(text, header_level)
		"h#{header_level}. #{text}\n"
	end

	def hrule()
		"----\n"
	end

	def list(contents, list_type)
		"#{contents}\n"
	end

	def list_item(text, list_type)
		marker = '-'
		if list_type.to_s == "ordered"
			marker = '#'
		end
		"#{marker} #{text}"
	end

	def paragraph(text)
		"#{text}\n\n"
	end

	def autolink(link, link_type)
		"[#{link}]"
	end

	def codespan(code)
		"{code}#{code}{code}"
	end

	def double_emphasis(text)
		"*#{text}*"
	end

	def emphasis(text)
		"_#{text}_"
	end

	def image(link, title, alt_text)
		alt_text.to_s.empty? ? "!#{link}!" : "!#{link}|alt=#{alt_text}!"
	end

	def linebreak()
		"\n"
	end

	def link(link, title, alt_text)
		alt_text.to_s.empty? ? "[#{link}]" : "[#{alt_text}|#{link}]"
	end

	def raw_html(raw_html)
		#TODO: parse the separate tags along with block_html and make replacements where applicable
		raw_html
	end

	def triple_emphasis(text)
		"*#{text}*"
	end

	def strikethrough(text)
		"-#{text}-"
	end

	def superscript(text)
		"^#{text}^"
	end

	def entity(text)
		"#{text}"
	end

	def normal_text(text)
		escape "#{text}"
	end

	def escape(text)
		#TODO: Check if anything else needs to be escaped
		text.gsub(/\{|\}/, '\\\\\0') #This replaces { with \{
	end
end