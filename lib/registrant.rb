class Registrant
    attr_reader :name, :age, :license
    def initialize(name, age, license)
        @name = name
        @age = age
        @license = false
        @registrant = Registrant.new(name, age, license)
    end
    def earn_permit
        @license = true
    end
end