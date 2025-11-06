Block("PunchCombo") {
    attributes = {
        max_combo_hits = 5,
        reset_time = 0.5,
        current_combo = 1,
    }

    tags = {
        "@Ability" // basically tags will allow to pass attribute pointers to other blocks
    }

    // whenever you execute a block from other block 
    // created block will store a list of tags (saved_tags)
    // which will point to the attribute table of the selected tag
    // whenever you create a new block from block with saved tags
    // it will clone this saved tags table (not clone but point to this table)
    // so, whenever you are to add a new tag into that table, it will
    // add this tag to the original table so every block will have access to it

    behavior = {
        if (not canActivate) { stop }
        execute("ComboController", {current_combo = get("current_combo")}) // writes current_combo into ComboController attributes
        increment("current_combo", 1)
        if (get("current_combo") > get("max_combo_hits")) { set("current_combo", 1) }
    }
}

Block("ComboController") {
    attributes = {}

    behavior = {
        if (not check("current_combo")) { stop }
        if (not exists(concat("Combo", get("current_combo")))) { stop }
        execute(concat("Combo", get("current_combo"))) // parent block will be passed as an argument automatically
    }
}

Block("Combo1") {
    attributes = {
        duration = 1
        cooldown = 0.3,
        animation = "test",
        damage = 30,
        size = 1,
    }

    tags = {
        "@HitboxLink"
    }

    behavior = {
        set("hitbox", execute("CreateHitbox", { inherit_tags = false }))
        // that way we will apply tags only from Combo1 to the 
        // CreateHitbox block, without taking any of saved_tags variables

        subscribe{from = get("hitbox"), event = "OnHit", to = "HitboxDamage", as = "TestConnection"} 
        // either that or simple arguments with types (which is better)

        execute("PlayAnimation", {animation = get("animation")})
        wait(get("duration"))

        unsubscribe{from = get("hitbox"), event = "OnHit", as = "TestConnection"}
        execute("ApplyCD", {cooldown = get("cooldown"), name = get("@Ability.name")})
    }
}

Block("HitboxDamage") {
    attributes = {}

    behavior = {
        set("characters", execute("FilterHitboxParts", {parts = get("parts", get("hitbox"))}))
        execute("ApplyDamage", {damage = get("@HitboxLink.damage"), characters = get("characters")})
    }
}

Block("CreateHitbox") {
    // this one could be created via lua script
    // lets say that it triggers OnHit and somehow can get to the @HitboxLink
}

Block("FilterHitboxParts") {
    // this one will mostly act as a function, so it could be also described only via lua
}

вся структура состоит из блоков (которые можно объявлять при помощи Block)
через execute можно вызывать другие блоки, в которые подобным образом
execute("ComboController", {current_combo = get("current_combo"), name = "PunchCombo"})
можно передавать аргументы

дополнительные env functions как set или execute можно добавить либо через
setfenv, либо сделать модуль, в котором будут прописаны все эти методы

у сами блоков можно будет редактировать аттрибуты, прописывать логику, подписываться и кидать ивенты
таким образом какой-нибудь ComboController мы сможем переиспользовать в любых способностях
с Combo

Мне не особо нравится connections, т.к прямо сейчас я не могу записать его в отдельный блок
(т.е пока что я не могу переиспользовать логику на OnHit) но мб что-то придумаю с этим

сейчас в коде это выглядит не прям легко, но мб можно будет сделать плагин
при помощи которого реализовать блочное программирование 

Что думаете? Мб есть идеи по улучшению?

Block()


Ability("PunchCombo") {
    combo = { max_hits = 5, reset_time = 0.5, current = 0 },
    stats = { base_damage = 15, crit_chance = 0.1, crit_multiplier = 1.5 },

    events = {
        OnInput = {
            input = "LeftClick",
            flow = {
                If("CanActivate", { ability = "PunchCombo" }, {
                    Increment("combo.current"),
                    Call("PlayComboStage"),
                    If("ComboIndexGreaterThan", { limit = 5 }, { Reset("combo.current") })
                })
            }
        }
    },

    stages = {
        Stage1 = {
            cooldown = 0.3, anim = "Punch_1", damage = 20, hitbox_radius = 1.0,
            effects = { { name="Bleed", trigger="OnHit", target="Enemy", params={dps=5, duration=4} } }
        },
        Stage2 = {
            cooldown = 0.35, anim = "Punch_2", damage = 25, hitbox_radius = 1.1,
            effects = { { name="Bleed", trigger="OnHit", target="Enemy", params={dps=5, duration=4} } }
        },
        Stage3 = {
            cooldown = 0.4, anim = "Punch_3", damage = 30, hitbox_radius = 1.2,
            effects = {
                { name="Poison", trigger="OnHit", target="Enemy", params={dps=6, duration=4} },
                { name="Bleed", trigger="OnHit", target="Enemy", params={dps=5, duration=4} }
            }
        },
        Stage4 = {
            cooldown = 0.45, anim = "Punch_4", damage = 35, hitbox_radius = 1.3,
            effects = { { name="Bleed", trigger="OnHit", target="Enemy", params={dps=5, duration=4} } }
        },
        Stage5 = {
            cooldown = 0.5, anim = "Punch_5_Finisher", damage = 45, hitbox_radius = 1.5,
            effects = { { name="Bleed", trigger="OnHit", target="Enemy", params={dps=5, duration=4} } },
            on_finish = { function(ctx) Reset("combo.current") end }
        }
    },

    passives = { "BleedingStrike" }
}
