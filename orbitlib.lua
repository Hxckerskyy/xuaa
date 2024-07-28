local OrbitingLibrary = {}

function OrbitingLibrary.SquareOrbit(TargetPosition, OrbitRadius, AngleOffset, HeightOffset)
    local offset = AngleOffset % (2 * math.pi)
    local half = OrbitRadius / math.sqrt(2)
    
    local segment = math.floor(offset / (math.pi / 2)) % 4
    local t = (offset % (math.pi / 2)) / (math.pi / 2)

    local corners = {
        {TargetPosition.X + half, TargetPosition.Z + half},
        {TargetPosition.X + half, TargetPosition.Z - half},
        {TargetPosition.X - half, TargetPosition.Z - half},
        {TargetPosition.X - half, TargetPosition.Z + half}
    }

    local cornerStart = corners[segment + 1]
    local cornerEnd = corners[(segment + 1) % 4 + 1]

    local x = cornerStart[1] + (cornerEnd[1] - cornerStart[1]) * t
    local z = cornerStart[2] + (cornerEnd[2] - cornerStart[2]) * t

    local y = TargetPosition.Y + HeightOffset  -- Constant height offset

    return Vector3.new(x, y, z)
end

function OrbitingLibrary.TriangleOrbit(TargetPosition, OrbitRadius, AngleOffset, HeightOffset)
    local offset = AngleOffset % (2 * math.pi)
    local side = OrbitRadius * math.sqrt(3)
    local segment = math.floor(offset / (2 * math.pi / 3)) % 3
    local t = (offset % (2 * math.pi / 3)) / (2 * math.pi / 3)

    local corners = {
        {TargetPosition.X, TargetPosition.Z + (side * math.sqrt(3) / 2)},
        {TargetPosition.X - (side / 2), TargetPosition.Z - (side * math.sqrt(3) / 4)},
        {TargetPosition.X + (side / 2), TargetPosition.Z - (side * math.sqrt(3) / 4)}
    }

    local cornerStart = corners[segment + 1]
    local cornerEnd = corners[(segment + 1) % 3 + 1]

    local x = cornerStart[1] + (cornerEnd[1] - cornerStart[1]) * t
    local z = cornerStart[2] + (cornerEnd[2] - cornerStart[2]) * t

    local y = TargetPosition.Y + HeightOffset  -- Constant height offset

    return Vector3.new(x, y, z)
end

function OrbitingLibrary.CircleOrbit(TargetPosition, OrbitRadius, AngleOffset, HeightOffset)
    local circleX = TargetPosition.X + math.cos(AngleOffset) * OrbitRadius
    local circleZ = TargetPosition.Z + math.sin(AngleOffset) * OrbitRadius
    local circleY = TargetPosition.Y + HeightOffset  -- Constant height offset
    return Vector3.new(circleX, circleY, circleZ)
end

function OrbitingLibrary.HeartOrbit(TargetPosition, OrbitRadius, AngleOffset, HeightOffset)
    local angle = (AngleOffset % (2 * math.pi))
    local scaleFactor = 0.5
    local x = TargetPosition.X + OrbitRadius * scaleFactor * (16 * math.sin(angle) ^ 3)
    local z = TargetPosition.Z + OrbitRadius * scaleFactor * (13 * math.cos(angle) - 5 * math.cos(2 * angle) - 2 * math.cos(3 * angle) - math.cos(4 * angle))
    local y = TargetPosition.Y + HeightOffset  -- Constant height offset
    return Vector3.new(x, y, z)
end

return OrbitingLibrary
