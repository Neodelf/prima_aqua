class NoticeMailer < ActionMailer::Base
  default from: 'noreply@prima-aqua.ru'

  def product(options)
    @product = options
    #emails = 'lvl0nax@gmail.com,kolibri@topaza-pella.ru,utkin_@hotmail.com'
    emails = 'lvl0nax@gmail.com, utkin_@hotmail.com'
    # emails = "9856544@gmail.com,akvapolus@restsguide.ru,lider-aqva@metropost.ru"

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

    mail to: emails, subject: 'Заказ товара'
  end

  def call(options)
    @call = options
    #emails = 'lvl0nax@gmail.com,kolibri@topaza-pella.ru,utkin_@hotmail.com'
    emails = 'lvl0nax@gmail.com, utkin_@hotmail.com'
    # emails = "9856544@gmail.com,akvapolus@restsguide.ru,lider-aqva@metropost.ru"
    mail to: emails, subject: 'Заказ звонка'
  end

  def service(options)
    @service = options
    #emails = 'lvl0nax@gmail.com,kolibri@topaza-pella.ru,utkin_@hotmail.com'
    emails = 'lvl0nax@gmail.com, utkin_@hotmail.com'
    # emails = "9856544@gmail.com,akvapolus@restsguide.ru,lider-aqva@metropost.ru"
    mail to: emails, subject: 'Заказ обслуживания'
  end
end
