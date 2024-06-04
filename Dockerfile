#ベースイメージの指定
FROM ruby:3.1.4

#環境変数
ENV TZ Asia/Tokyo
ENV LANG ja_JP.UTF-8
ENV LC_ALL C.UTF-8
ENV EDITOR=vim
ENV PORT=8080

#dbにpostgreSQLを使用するので対象のパッケージをインストール
RUN apt-get update && apt-get install -y postgresql-client vim nodejs yarn cron

#appディレクトリを作成
RUN mkdir /my_sommelier
#コマンドを実行するディレクトリを/appに指定
WORKDIR /my_sommelier

#ローカルのGemfileとGemfile.lockをコンテナ内にコピー
COPY Gemfile /my_sommelier/Gemfile
COPY Gemfile.lock /my_sommelier/Gemfile.lock

#bundle installを実行
RUN bundle install

#ローカルの現在のディレクトリをコンテナ内にコピー
COPY . /my_sommelier

#後述のentrypoint.shを実行するための記述
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

#コンテナがリッスンするPORTを指定
EXPOSE 8080

#コンテナ作成時にサーバーを立てる
CMD ["rails", "server", "-b", "0.0.0.0"]