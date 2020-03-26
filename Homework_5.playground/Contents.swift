import UIKit

(1)

// Класс - это по сути схема объектов и инструкция, по которой действуют объекты. Объект это экземпляр класса. Объект уже непосредственно демонстрирует те функции и набор свойств класса, которому он принадлежит.


(2)
 
class Inventory {
    var items: [String]
    var money: Int
    var size: Int
    
    init() {
        items = []
        money = 1000
        size = 100
    }

    func info() -> String {
        return "Available place: \(size); Money: \(money); Items: \(items)"
    }
}

class Item {
    let name: String
    let size: Int
    let cost: Int
    
    init(name: String, size: Int, cost: Int) {
        self.name = name
        self.size = size
        self.cost = cost
    }
    
    func sell(from inventory: Inventory) -> String {
        if inventory.items.contains(name) {
            inventory.items.remove(at: inventory.items.firstIndex(of: name)!)
        }
        else {
            return "\(name) is not in your inventory"
        }
        inventory.size += size
        inventory.money += cost
        return "\(name) is sold."
    }
    
    func collect(to inventory: Inventory ) -> String {
        if size > inventory.size {
            return "Not enough place in inventory"
        }
        inventory.size -= size
        inventory.items += [name]
        return "\(name) placed in your inventory."
    }
    
    func remove(from inventory: Inventory) -> String {
        if inventory.items.contains(name) {
            inventory.items.remove(at: inventory.items.firstIndex(of: name)!)
        }
        else {
            return "\(name) is not in your inventory"
        }
        inventory.size += size
        return "\(name) removed from inventory."
    }
}

class Weapon: Item {
    let ranged: Bool
    
    init(name: String, size: Int, cost: Int, ranged: Bool = false) {
        self.ranged = ranged
        super.init(name: name, size: size, cost: cost)
    }
    
    override func collect(to inventory: Inventory) -> String {
        if ranged {
            return super.collect(to: inventory) + " This is for ranged attack."
        }
        else {
            return super.collect(to: inventory) + " This is for melee."
        }
    }
}

class Armor: Item {
    let defenceFromMagic: Bool
    
    init(name: String, size: Int, cost: Int, defenceFromMagic: Bool = false) {
        self.defenceFromMagic = defenceFromMagic
        super.init(name: name, size: size, cost: cost)
    }
    
    override func collect(to inventory: Inventory) -> String {
        if defenceFromMagic {
            return super.collect(to: inventory) + " This is for defence. Its also protect from spells"
        }
        else {
            return super.collect(to: inventory) + " This is for defence."
        }
    }
}

class Consumable: Item {
    init(name: String, size: Int) {
        super.init(name: name, size: size, cost: 0)
    }
    
    override func sell(from inventory: Inventory) -> String {
        return "This is not for sale"
    }
}

let box = Inventory()
let sword = Weapon(name: "Sword", size: 25, cost: 500)
let arbalest = Weapon(name: "Arbalest", size: 25, cost: 600, ranged: true)
let chestArmor = Armor(name: "Chest Armor", size: 35, cost: 400)
let magicHelmet = Armor(name: "Magic Helmet", size: 15, cost: 800, defenceFromMagic: true)
let healthPotion = Consumable(name: "Health Potion", size: 5)

box.info()

sword.collect(to: box)
box.info()

arbalest.collect(to: box)
box.info()

magicHelmet.collect(to: box)
box.info()

chestArmor.collect(to: box)
box.info()

healthPotion.collect(to: box)
box.info()

arbalest.sell(from: box)
box.info()

healthPotion.collect(to: box)
box.info()

healthPotion.sell(from: box)
box.info()

healthPotion.remove(from: box)
box.info()

healthPotion.remove(from: box)
box.info()





protocol Animatable {
    func animate(in: Map) -> String
}

protocol Attackable {
    func attack() -> String
}

protocol Movable {
    func move(in: Map) -> String
}

protocol Drawable {
    func draw(in: Map) -> String
}

class StaticObject: Drawable {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func draw(in: Map) -> String {
        return "\(name) is drawn"
    }
}

extension StaticObject: Animatable {
    func animate(in: Map) -> String {
        return "\(name) is animate"
    }
}

class Tree: StaticObject {
    
}

class Statue: StaticObject {

}

class MovingObject: Animatable {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func animate(in: Map) -> String {
        return "\(name) is animate"
    }
}

extension MovingObject: Movable {
    func move(in: Map) -> String {
        return "\(name) moving"
    }
}

class Player: MovingObject {

}

extension Player: Attackable {
    func attack() -> String {
        return "\(name) attacks"
    }
}

class Enemy: MovingObject {

}

extension Enemy: Attackable {
    func attack() -> String {
        return "\(name) attacks"
    }
}

class Torch: MovingObject {
    
}

class Flag: MovingObject {
    
}

class Map {
    func animate(objects: Animatable...) -> String {
        var result = ""
        for object in objects {
            result += object.animate(in: self) + "; "
        }
        return result
    }
    
    func attack(objects: Attackable...) -> String {
        var result = ""
        for object in objects {
            result += object.attack() + "; "
        }
        return result
    }
    
    func draw(objects: Drawable...) -> String {
        var result = ""
        for object in objects {
            result += object.draw(in: self) + "; "
        }
        return result
    }
    
    func move(objects: Movable...) -> String {
        var result = ""
        for object in objects {
            result += object.move(in: self) + "; "
        }
        return result
    }
}

let map = Map()
let tree = Tree(name: "Bare tree")
let statue = Statue(name: "Monster statue")
let player1 = Player(name: "Elf")
let player2 = Player(name: "Orc")
let enemy1 = Enemy(name: "Big monster")
let enemy2 = Enemy(name: "Small monster")
let torch = Torch(name: "Torch")
let flag = Flag(name: "Flag")

map.animate(objects: tree, statue, player1, player2, enemy1, enemy2, torch, flag)
map.attack(objects: player1, player2, enemy1, enemy2)
map.draw(objects: tree, statue)
map.move(objects: player1, player2, enemy1, enemy2, torch, flag)





class Configuration {
    let name: String
    let price: Int
    let color: String
    let engineCapacity: Double
    
    init(name: String, price: Int, color: String, engineCapacity: Double) {
        self.name = name
        self.price = price
        self.color = color
        self.engineCapacity = engineCapacity
    }
}

class Model {
    let configuration: Configuration
    let model: String
    let photo: String
    
    
    init(model: String, photo: String, configuration: Configuration) {
        self.model = model
        self.photo = photo
        self.configuration = configuration
    }
    
    func configuration(_ name: Configuration) -> String {
        return "Configuration: \(name.name); Price: \(name.price); Color: \(name.color); Engine Capacity: \(name.engineCapacity)"
    }
}

let base = Configuration(name: "Base", price: 6651000, color: "Black", engineCapacity: 3.0)
let gts = Configuration(name: "GTS", price: 9804000, color: "White" , engineCapacity: 4.0)
let turbo = Configuration(name: "Turbo", price: 10868000, color: "Red", engineCapacity: 4.0)
let porschePanamera = Model(model: "Porsche Panamera", photo: "https://img-c.drive.ru/models.photos/0000/000/000/000/be3/48d3f9333fb6886e-large.jpg", configuration: turbo)
print(porschePanamera.configuration.name)
print(porschePanamera.configuration.price)
print(porschePanamera.configuration.color)
print(porschePanamera.configuration.engineCapacity)
porschePanamera.configuration(gts)

let advance = Configuration(name: "Advance", price: 5500000, color: "Black", engineCapacity: 3.0)
let design = Configuration(name: "Design", price: 6000000, color: "White", engineCapacity: 3.0)
let sport = Configuration(name: "Sport", price: 5915000, color: "Red", engineCapacity: 3.0)
let audiQ8 = Model(model: "Audi Q8", photo: "https://img-c.drive.ru/models.photos/0000/000/000/001/4b7/48d6925d5fa29c21-large.jpg", configuration: design)
print(audiQ8.configuration.name)
print(audiQ8.configuration.price)
print(audiQ8.configuration.color)
print(audiQ8.configuration.engineCapacity)
audiQ8.configuration(sport)

let luxury = Configuration(name: "Luxury", price: 5990000, color: "Black", engineCapacity: 6.2)
let premium = Configuration(name: "Premium", price: 6640000, color: "White", engineCapacity: 6.2)
let platinum = Configuration(name: "Platinum", price: 7750000, color: "Red", engineCapacity: 6.2)
let cadillacEscalade = Model(model: "Cadillac Escalade", photo: "https://img-c.drive.ru/models.photos/0000/000/000/000/77c/48d275692298c3a9-large.jpg", configuration: platinum)
print(cadillacEscalade.configuration.name)
print(cadillacEscalade.configuration.price)
print(cadillacEscalade.configuration.color)
print(cadillacEscalade.configuration.engineCapacity)
cadillacEscalade.configuration(luxury)


(3)

//let v1: A = D()
//
//v1.a()
//
// Ответ: A

//let v2: B = C() - класс С не использует протокол B, поэтому не может быть его типом
//
//v2.c() - эта строчка соответственно тоже не скомпилируется

//let v3: C = D()
//
//v3.d() - d() не является методом класса C

//let v4: D = D()
//
//v4.a()
//
//Ответ: А
