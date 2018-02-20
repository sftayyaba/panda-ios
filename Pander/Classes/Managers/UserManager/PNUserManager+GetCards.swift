//
//  PNUserManager+CheckAddressSupported.swift
//  Pander
//
//  Created by Abdul Sami on 12/01/2018.
//

import Foundation

extension PNUserManager {
    
    //MARK: CheckAddressIsSupported/Method
    func getCards(SuccessBlock successBlock: @escaping ((_ successResponse: PNGetCardsBaseClass ) -> Void), FailureBlock failureBlock: @escaping ((_ error: Error?) -> Void)){
        
        let getCardsOperation:PNGetCardsOperation = PNGetCardsOperation()
            
            weak var weakSelf = self
            
            weakSelf?.notifyNetworkRequestStarted()
            
            getCardsOperation.didFinishSuccessfullyCallback = {
                response in
                weakSelf?.getNicks(SuccessBlock: { (nicks) in
                    weakSelf?.getDefaults(SuccessBlock: { (defaults) in
                        
                        weakSelf?.notifyNetworkRequestFinish()
                        
                        if let successResponse = response as? PNGetCardsBaseClass{
                            
                            successResponse.cards = successResponse.cards?.map({ (card) -> PNCards in
                                if let nick = nicks.cards["\(card.ccId!)"]{
                                    card.nick = nick
                                }
                                card.isDefault = defaults.card == "\(card.ccId!)"
//                                card.isDefault = card.isSelected
                                
                                if( weakSelf?.selectedCard == nil && card.isDefault){
                                    weakSelf?.selectedCard = card
                                }
                                
                                if (weakSelf?.selectedCard != nil && weakSelf?.selectedCard!.ccId! == card.ccId!){
                                    card.isSelected = true
                                }
                                
                                return card
                            })
                            
                            weakSelf?.cardsBaseObject = successResponse
                            
                            
                            successBlock(successResponse)
                        }else if let errorResponse = response as? ErrorBaseClass{
                            failureBlock(errorResponse)
                        }
                        
                        
                    }, FailureBlock: { (error) in
                        
                    })
                }, FailureBlock: { (error) in
                    
                })

                
                weakSelf?.notifyNetworkRequestFinish()
                
                
            }
            
            getCardsOperation.didFinishWithErrorCallback = {
                error in
                weakSelf?.notifyNetworkRequestFinish()
                failureBlock(error)
            }
            
            OnebyteNetworkOperationQueue.sharedInstance.addOperation(getCardsOperation)
        }
//    }
}

