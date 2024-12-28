# 使用官方 Ruby 映像
FROM ruby:3.3

# 設定工作目錄
WORKDIR /app

# 安裝系統依賴
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    yarn

# 複製 Gemfile 並安裝 gem
COPY Gemfile Gemfile.lock ./
RUN bundle install

# 複製專案檔案
COPY . .

# 開放埠號
EXPOSE 3000

# 預設執行指令
CMD ["rails", "server", "-b", "0.0.0.0"]
