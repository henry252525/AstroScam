require 'highline/import'
require 'pry'
require 'watir-webdriver'

SLEEP_DELAY = 3

username = ask("Enter your username: ") { |q| q.echo = true }
password = ask("Enter your password: ") { |q| q.echo = "*" }

browser = Watir::Browser.start(
  "https://www.masteringastronomy.com/site/login.html",
  :chrome
)

browser.text_field(:id => 'nme').set username
browser.text_field(:id => 'pwd').set password
browser.form(:id => 'loginForm').submit

sleep SLEEP_DELAY
browser.goto "http://wps.aw.com/aw_bennett_tcp_7_msa/233/59832/15317073.cw/index.html"

sleep SLEEP_DELAY
chapter_list = browser.frame(:name => 'toolbar').when_present
  .select_list(:id => 'menuselect')
  .options
  .map { |opt| opt.text }
  .find_all { |opt| opt =~ /^Chapter .?\d/ }

chapter_list.reverse!

chapter_list.each do |chapter|
  #puts "=" * chapter.length
  #puts "#{chapter}"
  #puts "=" * chapter.length
  puts "\\section{#{chapter}}"

  browser.frame(:name => 'toolbar').when_present
    .select_list(:id => 'menuselect')
    .options
    .find { |opt| opt.text == chapter}
    .click

  browser.frame(:name => 'toolbar').when_present.input(:name => 'gonav').click

  ['Reading Quiz', 'Concept Quiz'].each do |quiz_type|
    contentFrame = browser.frame(:id => 'content').when_present
    current_url = browser.url

    contentFrame.link(:text => quiz_type).click

    contentFrame
      .tables(:class => 'problemTypeBkgd')
      .each_with_index { |q, i| q.inputs[0].click if i.even? }

    contentFrame.form(:name => 'quizForm').submit

    questions = contentFrame.spans(:class => 'Ques')
    answers = contentFrame.spans(:class => 'CorOpt')

    #puts "=== #{quiz_type} ==="
    puts "\\subsection{#{quiz_type}}"
    questions.each_with_index do |element, index|
      #puts "Question #{index + 1}: #{element.text}"
      #puts "Answer: #{answers[index].text}"
      puts "\\textbf{Question #{index + 1}}: #{element.text} \\\\"
      puts "\\textbf{Answer}: #{answers[index].text} \\\\"
      puts
    end

    browser.goto current_url
    sleep SLEEP_DELAY
  end
end
