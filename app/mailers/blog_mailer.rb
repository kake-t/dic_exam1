class BlogMailer < ApplicationMailer
  def blog_mail(blog)
    @blog = blog
    mail to: @blog.user.email, subject: 'ブログを作成しました'
  end
end
