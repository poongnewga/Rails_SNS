class LottoController < ApplicationController
require ('open-uri')        # 웹 페이지 open 에 필요.
require ('json')            # JSON을 Hash로 변환하는데 필요.

before_action :set_lotto, only: [:index, :check]

  def index

  end

  def check
    if @result == "fail"
      redirect_to '/lotto', notice: "올바른 회차를 입력해주세요 :)"
    else
      render :index
    end
  end

  private
    # get_lotto_hash(회차) 로 로또 해쉬를 GET
    def get_lotto_hash(week="")

      # page에 해당 웹 페이지를 열어서 저장.
      page = open("http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=#{week}")
      # lotto_info 에 page 내용 (JSON 형식의 data) 을 읽어서 저장.
      lotto_info = page.read
      # lotto_hash 에 JSON 형식인 lotto_info 를 Hash 로 파싱(변환)하여 저장.
      lotto_hash = JSON.parse(lotto_info)

      @lotto_numbers = []

      lotto_hash.each do |k, v|      # get_info 해시의 모든 key-value 를 돌며,
        if k.include?('drwtNo')      # key 에 'drwtNo' 라는 문자열이 있으면(추첨 번호면)
          @lotto_numbers << v        # 그 value(번호) 를 drw_num 에 저장.
        end
      end

      @lotto_draw_number = lotto_hash["drwNo"]
      @lotto_numbers.sort!           # 번호 정렬하여 배열 업데이트
      @lotto_bonus = lotto_hash["bnusNo"]
      @result = lotto_hash["returnValue"]
    end

    def set_lotto
      @week = params[:week]
      get_lotto_hash(@week)
    end

end
