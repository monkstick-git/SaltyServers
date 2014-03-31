local function PreventDoubleRR(wep,ply)

        if (ply.NextPhysReload == nil) then

                ply.NextPhysReload = 0
                MsgAll(ply:Nick().." used unfreeze all")
                return false
        else
                
                local C = CurTime()
                if (C >= ply.NextPhysReload) then
                        ply.NextPhysReload = C + 0.3
                else
                        MsgAll(ply:Nick().." tried to use unfreeze all")
                        return false
                end
        end
end
hook.Add("OnPhysgunReload","BO_StopPhysgunRR",PreventDoubleRR)
