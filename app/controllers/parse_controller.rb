class ParseController < ApplicationController
    def index
        uri = URI("http://terms.naver.com/entry.nhn?docId=2335484&cid=51276&categoryId=51276")
        html_doc = Nokogiri::HTML(Net::HTTP.get(uri))
        @title = html_doc.css("div.h_group//h2").inner_text
        @hanja = html_doc.css("div.h_group//em").inner_text
    end
    
    def parsing
        @dicview = Dicdatum.all
    end
    
    def doparse
        #2327285.upto(2351334) do |dicnum|  전범위 입니다
        2330545.upto(2351334) do |dicnum|
        # nokogiri
        uri = URI("http://terms.naver.com/entry.nhn?docId=#{dicnum}&cid=51276&categoryId=51276")
        html_doc = Nokogiri::HTML(Net::HTTP.get(uri))
        title = html_doc.css("div.h_group//h2").inner_text
        rawhanja = html_doc.css("div.h_group//em").inner_text
        hanja = rawhanja.delete "[ " " ]"
        # db에 저장
        wordset = Dicdatum.new
        wordset.dicnum = dicnum
        wordset.title = title
        wordset.hanja = hanja
        wordset.save
        # 서버 응답을 위한 시간
        sleeptime = rand(500..1500) / 1000
        sleep sleeptime
        end
    end
    
end
