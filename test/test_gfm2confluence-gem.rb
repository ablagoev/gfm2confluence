require 'rubygems'
require 'helper'

class TestGfm2Confluence < Test::Unit::TestCase
	context 'the converter' do
		should "generate code block" do
			text = "```js\n//code\n```"
			expect = "{code}\n//code\n{code}\n\n"
			assert_equal(expect, Gfm2Confluence.convert(text))
		end

		should "generate block quote" do
			text = ">Blockquote"
			expect = "{quote}\nBlockquote\n\n{quote}\n"
			assert_equal(expect, Gfm2Confluence.convert(text))
		end

		should "generate block html" do
			text = "<div>\n<span>Test</span>\n</div>"
			expect = "<div>\n<span>Test</span>\n</div>\n"
			assert_equal(expect, Gfm2Confluence.convert(text))
		end

		should "generate header" do
			for i in 1..3 do
				level = "#" * i
				text = "#{level} Level#{i}"
				expect = "h#{i}. Level#{i}\n"
				assert_equal(expect, Gfm2Confluence.convert(text))
			end
		end

		should "generate hr" do
			expect = "----\n"
			assert_equal(expect, Gfm2Confluence.convert('***'))
			assert_equal(expect, Gfm2Confluence.convert('- - -'))
			assert_equal(expect, Gfm2Confluence.convert('---------------'))
		end

		should "generate list" do
			#Ordered lsits
			expect = "# Item 1\n# Item 2\n# Item 3\n\n"
			text = "1. Item 1\n2. Item 2\n3. Item 3"

			assert_equal(expect, Gfm2Confluence.convert(text))

			#Unorderd lists
			expect = "- Item 1\n- Item 2\n- Item 3\n\n"
			text = "* Item 1\n* Item 2\n* Item 3"

			assert_equal(expect, Gfm2Confluence.convert(text))
			text = "- Item 1\n- Item 2\n- Item 3"

			assert_equal(expect, Gfm2Confluence.convert(text))
		end

		should "generate a paragraph" do
			expect = "Paragraph text\n\n"
			text = expect

			assert_equal(expect, Gfm2Confluence.convert(text))
		end

		should "autolink" do
			expect = "[http://google.com/]\n\n"
			text = "http://google.com/"

			assert_equal(expect, Gfm2Confluence.convert(text))
		end

		should "generate code span" do
			text = "`//code`"
			expect = "{code}//code{code}\n\n"
			assert_equal(expect, Gfm2Confluence.convert(text))
		end

		should "generate double emphasis" do
			text = "**emphasis**"
			expect = "*emphasis*\n\n"

			assert_equal(expect, Gfm2Confluence.convert(text))			
		end

		should "generate emphasis" do
			text = "*emphasis*"
			expect = "_emphasis_\n\n"

			assert_equal(expect, Gfm2Confluence.convert(text))
		end

		should "generate image" do
			text = "![Alt text](/path/to/img.jpg)"
			expect = "!/path/to/img.jpg|alt=Alt text!\n\n"

			assert_equal(expect, Gfm2Confluence.convert(text))

			#Titles are not handled
			text = "![Alt text](/path/to/img.jpg \"Optional title\")"
			expect = "!/path/to/img.jpg|alt=Alt text!\n\n"

			assert_equal(expect, Gfm2Confluence.convert(text))
		end

		should "generate link" do
			#Link titles are not handled
			text = "This is [an example](http://example.com/ \"Title\") inline link."
			expect = "This is [an example|http://example.com/] inline link.\n\n"

			assert_equal(expect, Gfm2Confluence.convert(text))
		end

		should "generate raw html" do
			text = "<span>Test</span>"
			expect = "<span>Test</span>\n\n"

			assert_equal(expect, Gfm2Confluence.convert(text))
		end

		should "generate triple emphasis" do
			text = "***empahsis***"
			expect = "*empahsis*\n\n"

			assert_equal(expect, Gfm2Confluence.convert(text))
		end

		should "generate strikethrough" do
			text = "~~strike~~"
			expect = "-strike-\n\n"

			assert_equal(expect, Gfm2Confluence.convert(text))
		end

		should "generate superscript" do
			text = "^super"
			expect = "^super^\n\n"

			assert_equal(expect, Gfm2Confluence.convert(text))
		end

		should "generate entity" do
			text = "&amp;"
			expect = "&amp;\n\n"

			assert_equal(expect, Gfm2Confluence.convert(text))
		end

		should "generate normal text" do
			text = "normal text"
			expect = "normal text\n\n"

			assert_equal(expect, Gfm2Confluence.convert(text))

			text = "test if { } are escaped properly"
			expect = "test if \\{ \\} are escaped properly\n\n"

			assert_equal(expect, Gfm2Confluence.convert(text))
		end
	end
end