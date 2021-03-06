ActiveAdmin.register Order do


  index do
    selectable_column
    column :id
    column :name
    column "empty bottles", :customer_deposit
    column :customer_type
    column :customer_name
    column :customer_phone
    column :delivery_address
    column :delivery_time
    column :delivery_date
    column :customer_comment
    column :order_info do |order|
      @ar = []
      cost = 0.0
      prefix = ''
      hash = eval("#{order.order_info}")
      if hash['aquas'].present?
        hash['aquas'].each_pair do |_, aqua|
          name = Aqua.where(id: aqua['aqua']).pluck(:name).first
          volume = Volume.find(aqua['volume'])
          amount = aqua['amount'].to_i
          prc = OrderService.get_price(aqua['aqua'], aqua['volume'], amount)
          prc.to_f > 1 ? (cost += prc.to_f) : (prefix = 'Доворная')
          @ar.push({ name: "#{name} #{volume.value}", amount: amount, cost: prc })
        end
      end
      if hash['accessories'].present?
        hash['accessories'].each_pair do |_, product|
          id, klass = product['info'].split('-')
          pr = klass.classify.constantize.find_by(id: id)
          amount = product['amount'].to_i
          prc = amount*pr.price
          cost += prc
          @ar.push({ name: pr.title, amount: amount, cost: prc })
        end
      end
      table do
        tr do
          th do
            'Название'
          end
          th do
            'Кол-во'
          end
          th do
            'Цена'
          end
        end
        @ar.each do |item|
          tr do
            td do
              item[:name]
            end
            td do
              item[:amount]
            end
            td do
              item[:cost]
            end
          end
        end
      end
    end
    column :cost
    column :created_at
    column :updated_at
    column :short_description
    actions
  end



  show do
    attributes_table do
      row :id
      row :name
      row :customer_deposit do
        if order.customer_deposit
          'Достаточно пустых бутылей'
        else
          "Не достаточно пустых бутылей. Депозит: #{order.deposit}"
        end
      end
      row :customer_type
      row :customer_name
      row :customer_phone
      row :delivery_address
      row :delivery_time
      row :delivery_date
      row :customer_comment
      row :order_info do
        @ar = []
        cost = 0.0
        prefix = ''
        hash = eval("#{order.order_info}")
        if hash['aquas'].present?
          hash['aquas'].each_pair do |_, aqua|
            name = Aqua.where(id: aqua['aqua']).pluck(:name).first
            volume = Volume.find(aqua['volume'])
            amount = aqua['amount'].to_i
            prc = OrderService.get_price(aqua['aqua'], aqua['volume'], amount)
            prc.to_f > 1 ? (cost += prc.to_f) : (prefix = 'Доворная')
            @ar.push({ name: "#{name} #{volume.value}", amount: amount, cost: prc })
          end
        end
        if hash['accessories'].present?
          hash['accessories'].each_pair do |_, product|
            id, klass = product['info'].split('-')
            pr = klass.classify.constantize.find_by(id: id)
            amount = product['amount'].to_i
            prc = amount*pr.price
            cost += prc
            @ar.push({ name: pr.title, amount: amount, cost: prc })
          end
        end
        table do
          tr do
            th do
              'Название'
            end
            th do
              'Кол-во'
            end
            th do
              'Цена'
            end
          end
          @ar.each do |item|
            tr do
              td do
                item[:name]
              end
              td do
                item[:amount]
              end
              td do
                item[:cost]
              end
            end
          end
        end
      end
      row :cost
      row :created_at
      row :updated_at
      row :short_description
    end
  end


end
