const Math = {
    EAST: Vector(1, 0, 0),
    WEST: Vector(-1, 0, 0),
    NORTH: Vector(0, 1, 0),
    SOUTH: Vector(0, -1, 0),
    NORTH_EAST: Vector(1, 1, 0).Normalized(),
    NORTH_WEST: Vector(-1, 1, 0).Normalized(),
    SOUTH_EAST: Vector(1, -1, 0).Normalized(),
    SOUTH_WEST: Vector(-1, -1, 0).Normalized(),
    IsEast(angle: number): boolean{
        return angle > 345 || angle <= 15;
    },
    IsNorthEast(angle: number): boolean{
        return angle > 15 && angle <= 75;
    },
    IsNorth(angle: number): boolean{
        return angle > 75 && angle <= 105;
    },
    IsNorthWest(angle: number): boolean{
        return angle > 105 && angle <= 165;
    },
    IsWest(angle: number): boolean{
        return angle > 165 && angle <= 195;
    },
    IsSouthWest(angle: number): boolean{
        return angle > 195 && angle <= 255;
    },
    IsSouth(angle: number): boolean{
        return angle > 255 && angle <= 285;
    },
    IsSouthEast(angle: number): boolean{
        return angle > 285 && angle <= 345;
    }
};

export default Math;
