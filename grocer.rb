require "pry"
def consolidate_cart(cart)
  consolidated = {}
  cart.each do |item|
    item.each do |name, info|
      consolidated[name] = info
      consolidated[name][:count] = cart.count(item)
    end
  end
  consolidated
end

def apply_coupons(cart, coupons)
  if coupons == []
    return cart
  else
    coupon_cart = {}
    coupons.each do |discount|
      cart.each do |name, info|
        if name == discount[:item] && info[:count] >= discount[:num]
          coupon_cart[name + " W/COUPON"] = {
            price: discount[:cost],
            clearance: info[:clearance],
            count: info[:count] / discount[:num]
          }
          coupon_cart[name] = info
          coupon_cart[name][:count] = info[:count] % discount[:num]
        else
          coupon_cart[name] = info
        end
      end
    end
  end
  coupon_cart
end

def apply_clearance(cart)
  clear_cart = {}
  cart.each do |name, info|
    clear_cart[name] = info
    clear_cart[name][:price] = info[:price] - (info[:price] * 0.2) if info[:clearance] == true
  end
  clear_cart
end

def checkout(cart, coupons)
  final_cart = consolidate_cart(cart)
  final_cart = apply_coupons(final_cart, coupons)
  final_cart = apply_clearance(final_cart)
  final_cart.each do |name, info|
  end
end
