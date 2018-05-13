class NoticeMailer < ApplicationMailer

  def notice_mailer(picture)
    @picture = picture
    @picture_user_email = @picture.user.email

    mail to: @picture_user_email, subject: "投稿の確認メール"
  end

end
