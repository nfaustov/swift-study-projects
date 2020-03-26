import UIKit

// если мы знаем, что стороны прямоугольника расположены и двигаются только параллельно осям x и y, то можно реализовать через одну коордиату центра или какой-либо вершины

struct Rectangle {
    var origin: CGPoint
    private var _size: CGSize
    
    init(_ origin: CGPoint, _ size: CGSize) {
        self.origin = origin
        _size = size
        precondition(_size.width > 0 && _size.height > 0, "Size parameters must be a positive number")
    }
    
    var size: CGSize {
        get {
            return _size
        }
        set {
            precondition(newValue.width > 0 && newValue.height > 0, "Size parameters must be a positive number")
        }
    }

    var center: CGPoint {
        get {
            CGPoint(x: origin.x + size.width/2, y: origin.y + size.height/2)
        }
        set {
            origin.x = newValue.x - size.width/2
            origin.y = newValue.y - size.height/2
        }
    }
    
    var diagonal: CGFloat {
        return sqrt(size.height * size.height + size.width * size.width)
    }
    
    var square: CGFloat {
        return size.height * size.width
    }
    
    var perimeter: CGFloat {
        return (size.height + size.width) * 2
    }
    
    mutating func move(xAxis x: CGFloat, yAxis y: CGFloat) {
        origin.x += x
        origin.y += y
    }
}

var someRectangle = Rectangle(CGPoint(), CGSize(width: 5, height: 7))

print(someRectangle.diagonal)
print(someRectangle.square)
print(someRectangle.perimeter)
print(someRectangle.center)

someRectangle.size.height += 3
someRectangle.size.width -= 3

print(someRectangle.diagonal)
print(someRectangle.square)
print(someRectangle.perimeter)
print(someRectangle.center)

someRectangle.move(xAxis: 2, yAxis: 2)

print(someRectangle.diagonal)
print(someRectangle.square)
print(someRectangle.perimeter)
print(someRectangle.center)

someRectangle.center.x -= 2
someRectangle.center.y -= 2

print(someRectangle.diagonal)
print(someRectangle.square)
print(someRectangle.perimeter)
print(someRectangle.origin)


struct CircleStruct {
    private var _radius: Double
    var centerPosition: CGPoint
    
    init(radius: Double, _ position: CGPoint) {
        _radius = radius
        centerPosition = position
        precondition(_radius > 0, "Radius must be a positive number")
        
    }
    
    var radius: Double {
        get {
            return _radius
        }
        set {
            precondition(newValue > 0, "Radius must be a positive number")
        }
    }
    
    var diametre: Double {
        radius * 2
    }
    
    var circumference: Double {
        return diametre * Double.pi
    }
    
    var square: Double {
        return radius * radius * Double.pi
    }
}

var someCircle = CircleStruct(radius: 5.5, CGPoint(x: 3.3, y: 8.8))
someCircle.radius *= 3
print(someCircle.diametre)
print(someCircle.circumference)
print(someCircle.square)

someCircle.centerPosition.x += 1.7
someCircle.centerPosition.y += 1.2
print(someCircle.centerPosition)
