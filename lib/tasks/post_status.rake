namespace :post_status do
  desc '公開済みの投稿が指定の期間が過ぎたら、ステータスを「締切」に変更されるようにする'
  task update_post_status: :environment do
    Post.published.past_closing.find_each(&:closing!)
  end
end
