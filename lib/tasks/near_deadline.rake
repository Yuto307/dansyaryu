namespace :near_deadline do
  desc '締め切りまで24時間以内のものがあればメールで知らせる'
  task near_deadline_alert: :environment do
    posts = Post.all
    posts.each do |post|
      time_difference = (post.deadline - Time.now.in_time_zone('Tokyo')) / 3600 # AM9:00との時間差を時間単位で算出する
      if time_difference <= 39 && time_difference >= 15 == true # 次の日のスケジュールなのかユーザーがリマインド機能をオンにしているかを判定
        NearDeadlineMailer.near_deadline(post).deliver_now # メールを送信するためのメソッド
        p "メールを#{event.user.name}に送信しました" # ログに表示するメッセージ
      end
    end
  end
end
