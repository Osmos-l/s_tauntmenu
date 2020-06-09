sTaunt = sTaunt || {}

-- On DarkRP gamemode arg is the actual player job
-- On no DarkRP gamemode arg is the actual player usergroup

-- DarkRP :
    -- Restrict to one job :
    -- function( arg ) return arg.name == 'Citizen' end

    -- Restrict to one category :
    -- function( arg ) return arg.category == 'Cops' end

    -- Allow to all :
    -- function( arg ) return true end

-- You can add 7 categ and 127 sounds per categ. If you want more : contact my self
sTaunt['categ'] = 
{
    [1] = {
        -- Werhmacht
        ['filter'] = function( arg ) return arg.allemand end,
        ['sounds'] = {
            [1]    = {
                ['title'] = 'Allemand sound',
                ['path']  = 'allemand.wav'
            }
        }
    },
    [2] = {
        -- URSS
        ['filter'] = function( arg ) return arg.russe end,
        ['sounds'] = {
            [1]    = {
                ['title'] = 'Russe sound',
                ['path'] =   'Russe.wav'
            }
        }
    },
    [3] = {
        -- ALL
        ['filter'] = function( arg ) return true end,
        ['sounds'] = {
            [1]    = {
                ['title'] = 'Sound 1',
                ['path']  = 'vo/Breencast/br_collaboration01.wav'
            },
            [2]    = {
                ['title'] = 'Sound 2',
                ['path']  = 'vo/Breencast/br_collaboration01.wav'
            },
            [3]    = {
                ['title'] = 'Sound 3',
                ['path']  = 'vo/Breencast/br_collaboration01.wav'
            },
            [4]    = {
                ['title'] = 'Sound 4',
                ['path']  = 'vo/Breencast/br_collaboration01.wav'
            }
        }
    }
}

-- Interval between two sounds in seconds
sTaunt['interval'] = 5 

sTaunt['wait'] = 'Please wait few seconds before start a new taunt'

-- Key to open panel ( https://wiki.facepunch.com/gmod/Enums/KEY )
sTaunt['key']  = 98

-- Command to open panel
sTaunt['command'] = '!taunt'