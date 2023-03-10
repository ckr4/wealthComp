# libraries
library(dplyr)
library(echarts4r)

plot_h <- function(c_sel, bill_sel, wealth) {
  # icon for stack of bills
    stack2_uri <- "image://data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBzdGFuZGFsb25lPSJ5ZXMiPz4KPHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIzODAiIGhlaWdodD0iMTM1Ij4KPHBhdGggc3R5bGU9ImZpbGw6IzAxMDEwMTsgc3Ryb2tlOm5vbmU7IiBkPSJNMCAwTDAgMTM1TDM4MCAxMzVMMzgwIDBMMCAweiIvPgo8cGF0aCBzdHlsZT0iZmlsbDojNDU1ZjUzOyBzdHJva2U6bm9uZTsiIGQ9Ik0xMyA4TDEzIDQ1TDE0LjAyNzggNTguMzk2NkwyMyA2MEw0NiA2MEwxNDIgNjBMMTQyIDU5TDE0IDU5QzE0IDQ0LjY4OTIgMTguNTA4NCAyMS4xMjczIDEzIDh6Ii8+CjxwYXRoIHN0eWxlPSJmaWxsOiM2Y2NkYTE7IHN0cm9rZTpub25lOyIgZD0iTTE0IDhMMTQgNTlMMTQxIDU5TDE0MSA4TDE0IDh6Ii8+CjxwYXRoIHN0eWxlPSJmaWxsOiM4NTgzNzU7IHN0cm9rZTpub25lOyIgZD0iTTE0MSA4TDE0MSA1OUwxNDIgNTlDMTQyIDQ0LjY4OTEgMTQ2LjUwOCAyMS4xMjczIDE0MSA4TTE1OCA4TDE1OCA1OUwxNTkgNTlDMTU5IDQ0LjY4OTEgMTYzLjUwOCAyMS4xMjczIDE1OCA4eiIvPgo8cGF0aCBzdHlsZT0iZmlsbDojZjZmMmNlOyBzdHJva2U6bm9uZTsiIGQ9Ik0xNTkgOEwxNTkgNTlMMjI3IDU5TDIyNyA4TDE1OSA4eiIvPgo8cGF0aCBzdHlsZT0iZmlsbDojNmNjZGExOyBzdHJva2U6bm9uZTsiIGQ9Ik0yNDQgOEwyNDQgNTlMMzcyIDU5TDM3MiA4TDI0NCA4eiIvPgo8cGF0aCBzdHlsZT0iZmlsbDojNDU1ZjUzOyBzdHJva2U6bm9uZTsiIGQ9Ik0xNTggNTlMMTU4IDYwTDIyNyA2MEwyMDUgNTlMMTU4IDU5TTI0NCA1OUwyNDQgNjBMMzcyIDYwQzM2MS43MzQgNTUuNjkyMyAzNDQuMTU4IDU5IDMzMyA1OUwyNDQgNTlNOCA3NEw4IDc1TDEzNiA3NUMxMjUuNzM0IDcwLjY5MjMgMTA4LjE1OCA3NCA5NyA3NEw4IDc0eiIvPgo8cGF0aCBzdHlsZT0iZmlsbDojODU4Mzc1OyBzdHJva2U6bm9uZTsiIGQ9Ik0xNTMgNzRMMTUzIDc1TDIyMSA3NUwyMjEgMTI2QzIyNS4zMDggMTE1LjczNCAyMjIgOTguMTU4MSAyMjIgODdDMjIyIDgzLjg0OTIgMjIzLjIxNiA3Ny4yNjEgMjIwLjM5NyA3NS4wMjc4QzIxNi43MDYgNzIuMTA0OSAyMDYuNTEzIDc0IDIwMiA3NEwxNTMgNzR6Ii8+CjxwYXRoIHN0eWxlPSJmaWxsOiM0NTVmNTM7IHN0cm9rZTpub25lOyIgZD0iTTIyMSA3NEwyMjIgNzVMMjIxIDc0TTIzOCA3NEwyMzggNzVMMzY2IDc1TDM2NSAxMjZMMzY2IDEyNkMzNzAuNTEyIDExMC43MzYgMzY3IDg5LjkzMTQgMzY3IDc0TDIzOCA3NHoiLz4KPHBhdGggc3R5bGU9ImZpbGw6IzZjY2RhMTsgc3Ryb2tlOm5vbmU7IiBkPSJNOCA3NUw4IDEyNkwxMzYgMTI2TDEzNiA3NUw4IDc1eiIvPgo8cGF0aCBzdHlsZT0iZmlsbDojZjZmMmNlOyBzdHJva2U6bm9uZTsiIGQ9Ik0xNTMgNzVMMTUzIDExMUwxNTQuMDI4IDEyNC4zOTdMMTcxIDEyNkwyMjEgMTI2TDIyMSA3NUwxNTMgNzV6Ii8+CjxwYXRoIHN0eWxlPSJmaWxsOiM4NTgzNzU7IHN0cm9rZTpub25lOyIgZD0iTTIzOCA3NUwyMzggMTI1TDIzOSAxMjVDMjM5IDExMC45NTEgMjQzLjQwOSA4Ny44ODk3IDIzOCA3NXoiLz4KPHBhdGggc3R5bGU9ImZpbGw6IzZjY2RhMTsgc3Ryb2tlOm5vbmU7IiBkPSJNMjM5IDc1TDIzOSAxMjZMMzMzIDEyNkwzNTYgMTI2TDM2NC45NzIgMTI0LjM5N0wzNjYgMTExTDM2NiA3NUwyMzkgNzVNMTUzIDEyNUwxNTQgMTI2TDE1MyAxMjV6Ii8+CjxwYXRoIHN0eWxlPSJmaWxsOiM0NTVmNTM7IHN0cm9rZTpub25lOyIgZD0iTTIzOCAxMjVMMjM5IDEyNkwyMzggMTI1eiIvPgo8L3N2Zz4K"
  
  # set conversion factor
  bill_th <- .0043 # thickness in inches
  
  # TODO ------------> Need to move these into github pin
  img_ref_d <- c(1,5,10,20,50, 100)
  img_ref_max_y <- c(16500, 4400, 4400, 750, 320, 240)
  img_refs <- c("https://imgur.com/Zp3EIPC.png",
                "https://imgur.com/Oz7EN0u.png",
                "https://imgur.com/Oz7EN0u.png",
                "https://imgur.com/D2NDrdU.png",
                "https://imgur.com/Y3sies5.png", 
                "https://imgur.com/Y3sies5.png")
  img_ref_t <- c(3,3,3,3,3,-120)
  img_ref_l <- c(0,0,0,0,0,-183)
  img_ref_h <- c(492,492,492,492,492,650)
  img_ref_w <- c(770,770,770,770,770,1008)
  img_ref_txt <- c("GPS satellite\nAltitude: 12,500 miles",
                   "O3b satellite\nAltitude: 5,000 miles",
                   "O3b satellite\nAltitude: 5,000 miles",
                   "Iridium Satellite\nAltitude: 485 miles",
                   "The International Space Station\n\n\n\n\nAltitude: 254 miles",
                   "The International Space Station\nAltitude: 254 miles")
  img_ref_txt_pos <- c("insideTop","insideTop","insideTop","top",
                       "top", "insideTop")
  img_ref_rot <- c(0,0,0,0,0,0)
  img_ref_os <- list(c(118,120), c(-32,12), c(-32,12), c(200,146), c(75,170), c(96,192))
  
  # calculate height based on wealth and bill denomination and convert to feet
  ht_miles = round(wealth$NetWorth[c_sel]*1000000000 / bill_sel * bill_th / 12 / 5280, 1)
  img_sel <- match(bill_sel, img_ref_d)
  ht_max_y <- img_ref_max_y[img_sel]
  
  # create dataframe for plotting
  df_ht <- data.frame(
    x=wealth$Name2[c_sel],
    value=ht_miles,
    nw=paste0(wealth$NetWorth[c_sel], ',', rep(bill_sel, length(c_sel)))
  )
  
  # create chart
  df_ht %>%
    e_charts(x) %>%
    e_pictorial(value, bind=nw,
                symbol=stack2_uri,
                symbolRepeat=TRUE,
                symbolSize=c(60,30),
                symbolMargin='0',
                symbolClip=TRUE) %>%
    e_title(paste0("Height of a stack of $", bill_sel, ' bills'), 
            x='left', padding=list(16,0,0,16), 
            textStyle=list(
              color="white", fontWeight='bold', fontSize=15, lineHeight=18),
    ) %>%
    e_legend(show=FALSE) %>%
    e_x_axis(splitLine=list(show=FALSE), 
             axisLabel=list(interval=0, rotate=45, color='white', 
                            fontWeight='bold', margin=14)) %>%
    e_y_axis(splitLine=list(show=FALSE),
             axisLabel=list(color='white', fontWeight='bold'),
             interval=ht_max_y/4, min=0, max=ht_max_y,
             name="Miles", 
             nameLocation="middle",
             nameTextStyle= list(
               color='white', fontSize=18, padding=list(0,0,30,0))
    ) %>%
    e_grid(top=70, bottom=110, left=90, right=60) %>%
    e_color(background='black') %>%
    e_image_g(
      top=img_ref_t[img_sel], 
      left=img_ref_l[img_sel], 
      z=-998,
      style = list(
        height=img_ref_h[img_sel], 
        width=img_ref_w[img_sel],
        image = img_refs[img_sel],
        opacity = 1,
        text=img_ref_txt[img_sel],
        textPosition=img_ref_txt_pos[img_sel],
        textOffset=img_ref_os[[img_sel]],
        textRotation=img_ref_rot[img_sel],
        textAlign='center',
        fontSize=12,
        fontStyle='bold',
        textFill='white')
    ) %>%
    e_tooltip(formatter=htmlwidgets::JS("
                                    function(params){
                                    var vals = params.name.split(',')
                                    return('<strong>' + params.value[0] + '</strong>' + 
                                    '<br />A stack of $' + '<strong>' + vals[0] + 
                                    '</strong> billion in $' + vals[1] + 
                                    '<br />bills would be <strong>' + 
                                    echarts.format.addCommas(params.value[1]) + 
                                    '</strong>' + ' miles high');
                                    }
                                    ")
    ) 
}


#plot_h(c(1,2,3,4,5), 20, wealth)
