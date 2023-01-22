namespace :post_status do
  desc '公開済みの投稿が指定の期間が過ぎたら、ステータスを「締切」に変更されるようにする'
  task update_post_status: :environment do
    Post.published.past_published.find_each(&:closing!)
  end
end
namespace :article_state do
    desc '公開待ちの中で、公開日時が過去になっているものがあれば、ステータスを「公開」に変更されるようにする'
    task update_article_state: :environment do
      Article.publish_wait.past_published.find_each(&:published!)
    end
  end