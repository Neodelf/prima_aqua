class NoticeMailer < ActionMailer::Base
  default from: 'noreply@prima-aqua.ru'

  EMAILS = 'info@prima-aqua.ru, akvapolus@restsguide.ru, lvl0nax@gmail.com'

  def product(options)
    @product = options
    @ar = []
    cost = 0.0
    prefix = ''
    hash = eval("#{@product.order_info}")
    if hash['aquas']
      hash['aquas'].each_pair do |_, aqua|
        name = Aqua.where(id: aqua['aqua']).pluck(:name).first
        volume = Volume.find(aqua['volume'])
        amount = aqua['amount'].to_i
        prc = OrderService.get_price(aqua['aqua'], aqua['volume'], amount)
        prc.to_f > 1 ? (cost += prc.to_f) : (prefix = 'Доворная')
        @ar.push({ name: "#{name} #{volume.value}", amount: amount, cost: prc })
      end
    end
    if hash['accessories']
      hash['accessories'].each_pair do |_, product|
        id, klass = product['info'].split('-')
        pr = klass.classify.constantize.find(id)
        amount = product['amount'].to_i
        prc = amount*pr.price
        cost += prc
        @ar.push({ name: pr.title, amount: amount, cost: prc })
      end
    end

    mail to: EMAILS, subject: 'Заказ товара'
  end

  def call(options)
    @call = options
    mail to: EMAILS, subject: 'Заказ звонка'
  end

  def service(options)
    @service = options
    mail to: EMAILS, subject: 'Заказ обслуживания'
  end
end
