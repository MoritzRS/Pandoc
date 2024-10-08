--- Add a page break before each level 1 header ---
function Header(element)
    if element.level == 1 then
        local title = pandoc.utils.stringify(element)
        return { pandoc.RawBlock('latex', '\\clearpage'), element }
    end
    return element
end

return {
    { Header = Header }
}