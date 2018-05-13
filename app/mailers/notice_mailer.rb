class NoticeMailer < ApplicationMailer

  def send_mail_picture(picture, email)
    @picture = picture

    mail to: email, subject: "投稿の確認メール"
  end

end
