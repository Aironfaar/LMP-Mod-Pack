#This script is executed before the mod is loaded, and can be omitted if not necessary.
#In this case, we're using it to define a custom ModLoadHandler
#So that the mod does nothing if ExampleMod isn't also loaded


def createModHandler #we put this code inside of a method so that the variables stay local
    mod_name = "LMP - ExampleSelectiveOverwriteMod" #change this to your mod name
    puts "Running before_load for mod #{mod_name}"

    $ModLoadHandlers[mod_name] = ModLoadHandler.new(mod_name)
    load_handler = $ModLoadHandlers[mod_name]

    
    #this is an example of how to make your mod selectively load stuff based on which other mods are present



    #if your mod uses content from other mods, (moves, abilities, items) and those other mods are not present, the game will crash upon trying to load a pokemon that uses those things
    #if you wish to prevent this, you must add placeholders for each and every thing that you use in your pokemon definitions
    #and set those things to not load if the wanted mod is already present using this file
    #this is a temporary workaround, once PBS loading is replaced by hashes
    #it will be possible to skip things if they aren't defined
    #which will also be done with this file.

    #this is the most basic thing we can do, just check if another mod is loaded before loading at all
    #but if you are familiar with how essentials works you can essential-ly do any condition you want
    
    
    #to check other common things, you can access:

    # $ModList = [] #format: array of str Mod names sorted by load order
    # $ModSettings = Hash[] # format: str Mod => hash of settings, these are the settings under the section [settings] in mod_settings.ini
    # $CustomModSettings = Hash[] # format: str Mod => hash of settings, these are the settings under the section [custom_settings] in mod_settings.ini
    # $ModMaps = Hash[] # format: int id => path to the map file, formatted as MapXXXXX.rxdata where XXXXX is the id
    # $ListOfModPokemonByParent a hash containing [species ID => Hash[:parent => (string) name of the mod that added it, :id => (int) id, :overwrite => (bool) whether this pokemon overwrote another]
    # PBSpecies::INTERNALNAME will return the ID of a pokemon depending on the internal name, or nil if it doesnt exist.
    # PBItems, PBAbilities and PBMoves all do the same thing
    # These can be used to check whether a specific thing is loaded before overwriting it
    # do NOT assign anything to these variables in here

    def load_handler.load_mod? #this is called when trying to load anything
        return is_loaded_before?("LMP - ExampleMod",@name) 
        #is_loaded_before? checks if a mod is loaded before another mod, in case our mod specifically depends on another mod
        #@name is the name given when creating the ModLoadHandler
        #you probably actually want to raise an error here if a dependency is missing
    end

    #the defs below this point aren't necessary to declare unless you are overwriting them, but this is left here as an example.
    
    def load_handler.load_move?(move) #this is called when trying to load a move
        return true
    end

    def load_handler.load_ability?(ability) #this is called when trying to load an ability
        return true
    end

    def load_handler.load_species?(species) #this is called when trying to load a pokemon species
        return true
    end

    def load_handler.load_item?(item) #this is called when trying to load an item
        return true
    end

    def load_handler.load_encounters?(map_id) #this is called when trying to load encounters for the specified map
        return true
    end

    def load_handler.load_map?(map_id) #this is called when trying to load a map
        return true
    end

    def load_handler.load_event?(map_id, event_id) # !not implemented yet as of 2022/5/19!
        return true
    end

end
createModHandler
