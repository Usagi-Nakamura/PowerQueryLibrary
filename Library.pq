[

    Function.Pipe = (x, l as list) => List.Accumulate(l, x, (state, current) => current(state))

    ,List.Cons = (a as any, l as list) => { a } & l

    ,List.Head = (l as list) => List.First(l)

    ,List.Tail = (l as list) => List.LastN(l, List.Count(l) - 1)

    ,List.ZipWith = 
        (f as function, la as list, lb as list) =>
            let 
                ans = f( List.Head(la), List.Head(lb) )
            in
                if List.Count(la) = 1
                    then { ans }
                    else List.Cons( ans, @List.ZipWith(f, List.Tail(la), List.Tail(lb)))

    ,List.Allocate =
        (l as list, n as number) =>
            if List.Count(l) = 1
                then { n }
                else
                    let
                        ans = Number.Round(n / List.Sum(l) * List.Head(l))
                    in
                        List.Cons( ans, @List.Allocate(List.Tail(l), n - ans))

    ,Text.ToHankaku = (t as nullable text) =>

        if t = null then null else

        let

            t_replaced = Text.Replace(t, "ー", "－"),

            GetItem =
                let FindFirst = (t as table, criteria as function) as record => Table.First(Table.SelectRows(t, criteria))
                in (criteria, key) => (t as table) => Record.Field(FindFirst(t, criteria), key),
            html =
                "<body><p id='p1'/></body>
                <script>
                    function toHankaku(s){
                        var fn = function(str) { return String.fromCharCode(str.charCodeAt(0) - 0xFEE0); }
                        return s.replace(/[０-９Ａ-Ｚａ-ｚ！-～]/g, fn);
                    }
                    document.getElementById('p1').insertAdjacentHTML('afterbegin', toHankaku('" & t_replaced & "'));
                </script>",
            data = List.Single(Web.Page(html)[Data]),
            手順 = {
                GetItem(each [Kind] = "Element", "Children")
                ,GetItem(each [Name] = "BODY", "Children")
                ,GetItem(each [Name] = "P", "Children")
                ,GetItem(each [Kind] = "Text", "Text")
            }

        in Function.Pipe(data, 手順)

]
