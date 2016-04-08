module APIBihang


    def addressesAddress(params={})
      get("addresses",params);
    end


    def buttonsListButton(params={})
      get("buttons",params);
    end


    def buttonsButton(params={})
      post("buttons",params);
    end


    def createOrderButton(id,params={})
      post("buttons/#{id}/create_order",params);
    end


    def listOrderButton(id,params={})
      get("buttons/#{id}/orders",params);
    end


    def listContacts(params={})
      get("contacts",params);
    end


    def testContacts(params={})
      post("contacts/test",params);
    end


    def listNation(params={})
      get("nations",params);
    end


    def applicationsOauth(params={})
      get("oauth/applications",params);
    end


    def applicationOauth(id,params={})
      get("oauth/applications/#{id}",params);
    end


    def createApplicationsOauth(params={})
      post("oauth/applications",params);
    end


    def listOrder(params={})
      get("orders",params);
    end


    def createOrder(params={})
      post("orders",params);
    end


    def detailOrder(id,params={})
      get("orders/#{id}",params);
    end


    def transactionDetailTransaction(id,params={})
      get("transactions/#{id}",params);
    end


    def payOrder4Step2Transaction(id,params={})
      put("transactions/#{id}/complete_send",params);
    end


    def cancelPayOrderTransaction(id,params={})
      put("transactions/#{id}/cancel_payorder",params);
    end


    def cancelPaymentOrderTransaction(id,params={})
      put("transactions/#{id}/cancel_send",params);
    end


    def cancelReceivePayOrderTransaction(id,params={})
      put("transactions/#{id}/cancel_request",params);
    end


    def simpleTransaction(params={})
      get("transactions",params);
    end


    def sendMoneyTransaction(params={})
      put("transactions/send_money",params);
    end


    def requestMoneyTransaction(params={})
      put("transactions/request_money",params);
    end


    def userInfoUser(params={})
      get("users",params);
    end


    def userBalanceUser(params={})
      get("users/balance",params);
    end


    def registeUser(params={})
      post("users",params);
    end


    def listWallet(params={})
      get("wallets",params);
    end


    def deleteWallet(id,params={})
      delete("wallets/#{id}/delete",params);
    end


    def createWallet(params={})
      post("wallets",params);
    end


    def setDefaultWallet(id,params={})
      put("wallets/#{id}/default",params);
    end


    def updateWallet(id,params={})
      put("wallets/#{id}/update",params);
    end


    def listDefaultWallet(params={})
      get("wallets/default",params);
    end
end