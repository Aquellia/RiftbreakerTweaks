function GetPodValue( field )
    local name = field:GetTypeName()

    local string_types = {
        "String",
        "IdString",
        "NarrowString",
        "WideString",
        "char",
        "wchar",
    };

    if IndexOf(string_types, name ) ~= nil then
        return field:GetValue()
    end

    local number_types = {
        "int8",
        "uchar",
        "short",
        "ushort",
        "int",
        "uint",
        "float",
        "double",
        "int64",
        "uint64",
    };

    if IndexOf(number_types, name ) ~= nil then
        return tonumber(field:GetValue())
    end

    if name == "bool" then
        return toboolean(field:GetValue())
    end

    return nil
end

TypeContainerHelper = {};
TypeContainerHelper.mt = {
    __index = function( self, key )
        local ptr = rawget(self, "__ptr");

        local count = ptr:GetItemCount()
        if key == "count" then
            return count
        elseif type(key) == 'number' then
            local item = ptr:GetItem(key - 1)
            if item == nil then
                return nil
            end

            local value = GetPodValue(item)
            if value ~= nil then
                return value
            end

            return reflection_helper( item )
        end

        return nil
    end,
    size = function( self )
        local ptr = rawget(self, "__ptr");
        return ptr:GetItemCount();
    end,
    __len = function( self )
        local ptr = rawget(self, "__ptr");
        return ptr:GetItemCount();
    end
}

TypeValueHelper = {};
TypeValueHelper.mt = {
    __index = function( self, key )
        local ptr = rawget(self, "__ptr");

        local field = ptr:GetField(key)
        if field == nil then
            return nil
        end

        local value = GetPodValue(field)
        if value ~= nil then
            return value
        end

        return reflection_helper( field )
    end,
    __newindex = function( self, key, value )
        local ptr = rawget(self, "__ptr");

        local field = ptr:GetField(key)
        if field == nil then
            return nil
        end

        field:SetValue(tostring(value))
    end
};

function reflection_helper( ptr )
    if ptr == nil then
        return nil
    end

    if ptr:IsContainer() then
        local instance = setmetatable( {}, TypeContainerHelper.mt );
        rawset(instance, "__ptr", ptr:ToContainer());
        return instance;
    else
        local instance = setmetatable( {}, TypeValueHelper.mt );
        rawset(instance, "__ptr", ptr);
        return instance;
    end
end