//
//  AppDelegate.swift
//  479FinalProject
//
//  Created by Jerdon Helgeson on 4/5/18.
//  Copyright © 2018 Jerdon Helgeson. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var GamesArray = [game]()
    var gameDataAdded = false;
    var gamesNS = [NSManagedObject]();


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //deleteGameCoreData()
        //fetchGameData()
        gameDataAdded = entityIsEmpty(entity: "Game")
        if(gameDataAdded == true)
        {addBaseData()}
        fetchGameData()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "_79FinalProject")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func addBaseData()
    {
        populateGamesArray()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        let context = appDelegate.persistentContainer.viewContext;
        guard let entity = NSEntityDescription.entity(forEntityName: "Game", in: context) else {fatalError("Could not find entity description")}
        
        for g in GamesArray
        {
            let gam2CD = NSManagedObject(entity: entity, insertInto: context)
            gam2CD.setValue(g.gameName, forKey: "gameName")
            gam2CD.setValue(g.classic, forKey: "classic")
            gam2CD.setValue(g.gameType, forKey: "gameType")
            gam2CD.setValue(g.imageFileName, forKey: "imageFileName")
            gam2CD.setValue(g.indoor, forKey: "indoor")
            gam2CD.setValue(g.materials, forKey: "materials")
            gam2CD.setValue(g.maxPlayers, forKey: "maxPlayers")
            gam2CD.setValue(g.minPlayers, forKey: "minPlayers")
            gam2CD.setValue(g.outdoor, forKey: "outdoor")
            gam2CD.setValue(g.rating, forKey: "rating")
            gam2CD.setValue(g.rules, forKey: "rules")
            gam2CD.setValue(g.alternateNames, forKey: "alternateNames")
        }
        do
        {
            try context.save()
            print("SAVED")
        }
        catch
        {
            //Process Error
        }
    }
    
    func fetchGameData(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        let context = appDelegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName : "Game")
        request.returnsObjectsAsFaults = false;
        GamesArray.removeAll()
        
        //let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
        do{
            let results = try context.fetch(request)
            if(results.count > 0)
            {
                gameDataAdded = true;
                for r in results
                {
                    gamesNS.append(r as! NSManagedObject)
                    
                    let rName = (r as AnyObject).value(forKey: "gameName") as? String
                    
                    print("fetched game: ", rName!)
                    let rImageFileName = (r as AnyObject).value(forKey: "imageFileName") as? String
                    let rClassic = (r as AnyObject).value(forKey: "classic") as? Bool
                    let rRating = (r as AnyObject).value(forKey: "rating") as? Double
                    let rGameType = (r as AnyObject).value(forKey: "gameType") as? String
                    let rIndoor = (r as AnyObject).value(forKey: "indoor") as? Bool
                    let rOutdoor = (r as AnyObject).value(forKey: "outdoor") as? Bool
                    let rMaterials = (r as AnyObject).value(forKey: "materials") as? String
                    let rMinPlayers = (r as AnyObject).value(forKey: "minPlayers") as? Int
                    let rMaxPlayers = (r as AnyObject).value(forKey: "maxPlayers") as? Int
                    let rRules = (r as AnyObject).value(forKey: "rules") as? String
                    let rAlternateNames = (r as AnyObject).value(forKey: "alternateNames") as? String
                    
                    let tempGame = game(gameName: rName!, imageFileName: rImageFileName!, classic: rClassic!, rating: rRating!, gameType: rGameType!, indoor: rIndoor!, outdoor: rOutdoor!, materials: rMaterials!, minPlayers: rMinPlayers!, maxPlayers: rMaxPlayers!, rules: rRules!, alternateNames: rAlternateNames!)
                    GamesArray.append(tempGame)
                    //
                }
            }
            
        } catch {print("There was a fetch error")}
    
    }
    
    
    func populateGamesArray()
    {
        let bpRules = "There are 2 teams, each team has 2 throws per turn unless otherwise stated,First team to eliminate the other teams' cups wins,Set 10 cups on both sides of table in 4-3-2-1 Formation, Determine which team goes first with Eye-To-Eye throws,A thrower's elbow must be behind the edge of the table (if someone makes a cup with elbow over the table the shot doesn't count), a bounced ball counts as two cups,A bounced ball may be slapped away or blocked by opponents,Both teammates making cups in a round is balls back,Making the same cup in a round is balls back and 3 cups removed,Cups must be removed after each round (Death cup optional),If one player makes 3 cups in a row they are 'On Fire' and must announce this to recieve the ball back until they miss, a missed shot that doesn't touch the ground may be retrieved and shot again as a 'trick shot',Each team only has two chances to re-rack the cups they are shooting on,Gentlemans re-rack (two cups remaining placed in a line) is always free,If a team makes the final cup the other team is allowed the chance to rebuttle and must make the equivalent defacit number of cups that were made against them in the last round to stay in the game,Anyone who makes 0 cups during the game must 'Troll' by sitting under the table for the duration of the next game"
        
        let rcRules = "This is a game of speed,\nArrange cups in a circle pattern in middle of table,\nFill cups lightly with drink,\nAll players must stand around the table with adaquate elbow room,\nSelect two players opposite eachother to start the game,\nTo begin playing both players must cheers and finish their drink,\nEach player must bounce the ball off the table into the cup or stack of cups in front of them,\nWhen a player makes their cup they pass it clocwise to the person next to them,\nIf the player makes it on the first bounce they can place the cup in front of any player except the other player with a cup,\nThe objective of this game is to 'Stack' the other players as much as possible,\nIt is only possible to stack the player immedietly to your right,\nTo stack someone both players must have a cup in front of them. If the person on the left can make their ball in the cup before the person on the right they may put their cup inside the other persons' cup 'Stacking them',\nWhen stacked the player must pass their stacked cup to the right and take a new cup out of the middle - they cannot bounce the ball until they have drank the liquid in the cup,\nThe person who is stacked last has an optional 'death cup' whose contents are decided upon by the group before the game is started,\nIf a player ever spills a cup they must 'Zamboni'(drink) it off of the table,\nIf a player ever accidentally bounces the ball into a full cup in the middle they must drink it and add it to their stack before continuing"
        let qtrsRules = "Place a glass in the middle of the table and pour a small amount of drink in it,\nPlayers must sit around the table and take turns clockwise,\nPlayers will attempt to bounce the quarter into the glass,\nEach player only gets one chance to bounce the quarter each turn,\nIf the player makes the quarter then they choose someone to drink and get to make up any rule,\nExamples of rules are:\n   No saying cerain words,   No pointing,   No looking at phones,    Etc...,\nIf a player breaks a rule they must take a drink"
        let kcRules = "Place an unopened can or cup with drink in it in the middle of the table,\nFan the cards around the cup/can in a circle until they completely surround it,\nEach person will take turns drawing cards from around the circle,\nEach card has a unique rule associated with it,\nWhen the player finishes their turn they place their card under the tab if its a can or flat on the top of the cup,\nWhoever pops the top on the can and releases the pressure or knocks the pile of cards off the top of the cup must finish the drink,\nCard Rules are as follows:\n   A - Waterfall,\n   2 - You,\n   3 - Me,\n   4 - Ladies,\n   5 - Jive,\n   6 - Gentlemen,\n   7 - Heaven,\n   8 - Mate,\n  9 - Rhyme,\n   10 - Categories,\n   J - Never Have I Ever,\n   Q - Hot Seat or Question Master,\n   K - Make up a rule"
        let sbRules = "Place cool chests filled with canned drinks near second base,\nSelect even teams,\nThis game follows all of the typical rules of kickball with a few tweaks,\nEvery player must always have an open drink in their hand at all times,\nIf at any time the player drops their drink their play doesn't count,\nMultiple people can be on second base at a time,\nPlayers on the kicking team are not allowed to pass second base until they finish the current drink in their hand and open a new one from the cool chest,\nIf a player cannot finish their current drink they must stay at second base until they can,\nIf the entire kicking team is on second base that counts as 3 outs and they are now the fielding team,\nFly Outs - Peg Outs - Tag Outs are all allowed,\nNo stealing bases"
        let fcRules = "Split players into two teams,\nEach player has a cup of drink in front of them on the table,\nStarting at one end of the table two players across from eachother on opposite teams cheers and finish their drinks,\nOnce the drink is finished they must place the cup upside down on the edge of the table and try to use one hand to flip it rightside up,\nOnce the player has flipped it rightside up the next player on their team may drink and flip,\nThis continues until one team has completed drinking and flipping all of its cups"
        let rtbRules = "Shuffle cards,\nEach player gets 4 face down cards,\nPlace 9 cards in the middle of the table face down in a row of 2s with the last odd card at the end,\n Each player will go around in the circle flipping the cards in front of them left to right,\nFor the first card they must guess the color before flipping,\nIf they get it correct they give 1 drink if not they take 1 drink,\nThe next card they guess if it is higher or lower than the first card and if the reward/consequence for this one is 2 drinks,\nThe third card they guess in between or outside the previous two card and it is worth 3 drinks,\nFourth card is worth 4 drinks and the player must guess its suit,\nNow the dealer flips the cards in the middle one at a time,\nAll cards on the right are take and all cards on the left are give,\nIf the first card on the right matches with any of your cards you must take one drink,\nSimilarly if the first card on the left matches any of your origional 4 cards you give one drink,\nThe second row of cards is worth 2 drinks,\nThird row is worth 3 drinks,\nFourth row is worth 4 drinks each,\nThe final card is a kill card,\nIf you have a card that matches the final card you must kill your drink"
        let mseRules = "Sit evenly around the table and decide who should start the game,\nThe player who starts bounces the coin off the table and into one of the ice cube basins,\nIf the coin does not land in a basin the player must take a drink,\nIf the coin lands in a basin the player must heed the directions on the tray,\nFor example if the coin landed in 'Give 3' the player points to someone and tells them to drink 3 times,\nAn alternative method is pointing to 3 people and telling them to all drink once,\nIf the coin lands in one of the 'moose' basins all players put their hands above their ears to look like a moose and yell 'MOOSE!'. The last player to yell 'MOOSE! must drink the contents of the moose cup or finish their drink in hand,\n Game play rotates to the left and the game continues until all players decide to quit."
        let lbRules = "Set up Ladder Ball rigs and place 15-40 feet apart facing eachother,\nTake turns throwing three rope balls towards the opposite ladder,\nIf the ball lands on the bottom rung it is worth 1 point,\n2 points for the second rung,\n3 points for the third rung,\nFirst player to 21 wins"
        let chRules = "Decide who goes first (usually the ugliest person) then take turns throwing bags with your opponent,\nYou throw one bag - then your opponent - then you - then your opponent - etc,\nYour feet may not go past the front edge of the board,\nIf a players feet cross the front edge of the board a foul is called and you get pelted with cornhole bags,\nA tossed bag may not touch the ground before it goes on the board,\nIf it hits the ground and bounces up on the board - remove it before any other bags are thrown,\nIf its hanging off the board and touching the ground - remove that as well,\nWhen all 8 bags have been tossed to the other side add up the score (see scoring below),\nIf you earned the most points in that single round - your team will throw first in the next round,\nDrink Casually while playing this game"
        let twsRules = "Place 16 cards face up on the table in a square,\nSet the rest of the cards in a draw pile,\nEach player takes a turn pointing at a face up card guessing higher or lower and drawing from the draw pile,\nPlace the drawn card on the face up card,\nIf the guess was correct then their turn is over,\nIf the guess was wrong take one drink for every card in the face up pile and go again,\nIf the card was the same value as the last take two drinks for every card in the face up pile,\nWhen the draw pile has been exhausted - pull an entire column or row of cards and set them face down as the new draw pile,\nContinue in this fashion until cards are gone"
        let ah2gRules = "This is a counting game,\n All players sit in an arrangement so they can see eachother,\nTurns are taken clockwise with each player saying one number per turn,\nThe first player says 1 - the second says 2 - 3 so on and so forth until they reach 21,\nInstead of saying 21 the last player will raise their glass and say 'Cheers to the Governor!' - All other players must cheers echo the call and take a drink,\nThe person to reach 21 gets to make up any rule,\nThere are two initial rules that must always be followed: 1. At 7 the player must instead say 14 - 2. At 14 the player must instead say 7,\nExamples of new rules that players can create are: Instead of 2 the player must drink - Players must say 9 in a high pitched voice - Players must skip multiples of 8 - etc...,\nIf a rule is ever broken then the person who broke the rule must drink and the count starts again from 1 with the person after the rule breaker,\nIf a player reaches 21 the count starts again at 1 with the player immediately to the left of the player who reached 21"
        let jngaRules = "Begin by writing fun and creative rules on every Jenga block,\nRules can be whatever you want,\nExamples of rules include: take a drink - give a drink - play a game - hot seat - whatever you want,\nPlay Jenga normally but you must follow whatever rule you pull on your Jenga block,\nIf the tower falls over - the person who knocked it over must finish their drink"
        
        let BP = game(gameName: "Beer Pong", imageFileName: "Cups.jpg", classic: true, rating: 5.0, gameType: "Party Game", indoor: true, outdoor: true, materials: "20 Cups, Water,2 Ping Pong Balls, 1 Table, Friends", minPlayers: 2, maxPlayers: 4, rules: bpRules, alternateNames: "BP, Water Pong")
        GamesArray.append(BP)
        let RC = game(gameName: "Rage Cage", imageFileName: "Cups.jpg", classic: true, rating: 5.0, gameType: "Party Game", indoor: true, outdoor: true, materials: "Cups, Any Drinks, Ping Pong Balls, 1 Table, Friends", minPlayers: 3, maxPlayers: 20, rules: rcRules, alternateNames: "Death Cup")
        GamesArray.append(RC)
        let QTRs = game(gameName: "Quarters", imageFileName: "GlassAndCoin.jpg", classic: true, rating: 4.0, gameType: "Party Game", indoor: true, outdoor: true, materials: "1 Cup or Glass, Any Drink, 1 Coin, 1 Table, Friends", minPlayers: 3, maxPlayers: 10, rules: rcRules, alternateNames: "Coin bounce")
        GamesArray.append(QTRs)
        let KC = game(gameName: "Kings Cup", imageFileName: "CanAndCards.jpg", classic: true, rating: 4.0, gameType: "Party Game", indoor: true, outdoor: true, materials: "1 Unopened Can,Any Drink per person, 1 Deck of Cards, 1 Table, Friends", minPlayers: 3, maxPlayers: 10, rules: kcRules, alternateNames: "AlternateNames to be completed")
        GamesArray.append(KC)
        let SB = game(gameName: "Slosh Ball", imageFileName: "kickball.jpeg", classic: false, rating: 5.0, gameType: "Field Game", indoor: false, outdoor: true, materials: "1 Kickball, Many Drinks, 1 or more Ice Chests, A field, Friends", minPlayers: 8, maxPlayers: 24, rules: sbRules, alternateNames: "AlternateNames to be completed")
        GamesArray.append(SB)
        let FC = game(gameName: "Flip Cup" , imageFileName: "Cups.jpg", classic: true, rating: 4.0, gameType: "Party Game", indoor: true, outdoor: true, materials: "Many Plastic Cups, Any Drinks, 1 Table, Friends", minPlayers: 2, maxPlayers: 20, rules: fcRules, alternateNames: "floopin chalice")
        GamesArray.append(FC)
        let RtB = game(gameName: "Ride the Bus", imageFileName: "rtbCards.jpeg", classic: false, rating: 3.0, gameType: "Card Game", indoor: true, outdoor: false, materials: "1 Deck of Cards, Any Drinks,  1 Table, Friends", minPlayers: 2, maxPlayers: 8, rules: rtbRules, alternateNames: "Alternate Names to be completed")
        GamesArray.append(RtB)
        let MSE = game(gameName: "Moose", imageFileName: "moose.jpg", classic: false, rating: 3.0, gameType: "Party Game", indoor: true, outdoor: false, materials: "Ice cube tray, Coin, Any Drinks, 1 Table, Friends", minPlayers: 4, maxPlayers: 12, rules: mseRules, alternateNames: "Alternate Names to be completed")
        GamesArray.append(MSE)
        let LB = game(gameName: "Ladder Ball", imageFileName: "LadderBall.jpg", classic: false, rating: 3.0, gameType: "Tailgate Game", indoor: false, outdoor: true, materials: "Ladder Ball Set, Any Drinks, Friends", minPlayers: 2, maxPlayers: 4, rules: lbRules, alternateNames: "Alternate Names to be completed")
        GamesArray.append(LB)
        let CH = game(gameName: "Corn Hole", imageFileName: "Cornhole.jpg", classic: false, rating: 5.0, gameType: "Tailgate Game", indoor: false, outdoor: true, materials: "Corn Hole Set, Any Drinks, Friends", minPlayers: 2, maxPlayers: 4, rules: chRules, alternateNames: "Alternate Names to be completed")
        GamesArray.append(CH)
        let TWs = game(gameName: "Towers", imageFileName: "Cards.jpg", classic: false, rating: 3.0, gameType: "Card Game", indoor: true, outdoor: false, materials: "1 Deck of Cards, Any Drinks,  1 Table, Friends", minPlayers: 2, maxPlayers: 8, rules: twsRules, alternateNames: "Alternate Names to be completed")
        GamesArray.append(TWs)
        let JNGA = game(gameName: "Jenga", imageFileName: "Jenga.jpg", classic: false, rating: 4.0, gameType: "Party Game", indoor: true, outdoor: false, materials: "1 Jenga Set, 1 Sharpie, Any Drinks, Friends", minPlayers: 2, maxPlayers: 8, rules: jngaRules, alternateNames: "Alternate Names to be completed")
        GamesArray.append(JNGA)
        let AH2G = game(gameName: "Cheers to the Governor", imageFileName: "hands.jpg", classic: false, rating: 4.0 , gameType: "Party Game", indoor: true, outdoor: true, materials: "Any Drinks, Friends", minPlayers: 3, maxPlayers: 10, rules: ah2gRules, alternateNames: "Alternate Names to be completed")
        GamesArray.append(AH2G)
        
    }
    
    func deleteGameCoreData()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        let context = appDelegate.persistentContainer.viewContext;
        //let newSettings = NSEntityDescription.insertNewObject(forEntityName: "Game", into: context);
        let request = NSFetchRequest<NSFetchRequestResult>(entityName : "Game")
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try context.execute(batchDeleteRequest)
            
        } catch {
            print("ohmygod")
        }
        
        
        do{
            var results = try context.fetch(request)
            results.removeAll();
        }catch{print("ohmygod")}
        
        for sNS in gamesNS
        {
            context.delete(sNS)
        }
        gamesNS.removeAll()
        //reloadData()
        
    }
    
    func entityIsEmpty(entity: String) -> Bool
    {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        let context = appDelegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName : "Game")
        
        do{
            let results = try context.fetch(request)
            if(results.count == 0)
            {
                return true;
            }
            else{return false}
        }catch
        {
            print("there was a fetch error in enityIsEmpty")
            return false
        }
        
    }

}

