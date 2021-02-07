Thống kê số SV thuộc 2 khối kỹ thuật và KTXH:
data <- read.table("F:/NTU/HoiThao/Khoa2021/Data_Tonghop.csv",sep = ",",row.names = 1, header = TRUE)
head(data)
kythuat=sum(data$Nhom.nganh=='Ky thuat')
#1727
ktxh=sum(data$Nhom.nganh=='KTXH')
#2969
sum(data2$TB==10)
# 393

Trong đó: XH có 18 ngành và KT có 25 ngành

Lọc dữ liệu
library(dplyr)
data <- read.table("F:/NTU/HoiThao/Khoa2021/Data_Tonghop2.csv",sep = ",",row.names = 1, header = TRUE)
data2=filter(data,TB>0)
grades<-data2$Code
summary(grades)

   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    1.0     3.0     4.0     3.9     5.0     7.0 

shapiro.test(grades)
	Shapiro-Wilk normality test
data:  grades
W = 0.92447, p-value < 2.2e-16

Dựa vào p-value < 2.2e-16 < 0.05.Nên ta có thể bác bỏ giả thuyết H0 hay biến grades không tuân theo luật phân bố chuẩn.

#Vẽ đồ thị histogram

library(ggplot2)
d <- data.frame(grades)
#ggplot(d, aes(grades, fill = cut(grades, 10))) + geom_histogram()

ggplot(d, aes(grades, fill = cut(grades, 10))) +
  geom_histogram(show.legend = FALSE) +
  scale_fill_discrete(h = c(240, 10), c = 120, l = 70) +
  theme_minimal() +
  labs(x = "Điểm trung bình", y = "Tổng số") +
  ggtitle("Phổ điểm Thực hành THCS từ 2018 đến 2020")

hist(trungbinh)
#Vẽ thêm đường phân bố chuẩn
curve(dnorm(x, mean=mean(trungbinh), sd=sd(trungbinh)), add=TRUE)

> library(nortest)
> ad.test(dat2$Code)

ks.test(data2$Code, "pnorm", mean=mean(data2$Code), sd=sd(data2$Code))

Thống kê điểm số:
sum(data$TB <5, na.rm=TRUE)
#624
sum(data$TB >=5 & data$TB <=6, na.rm=TRUE)
#1648
sum(data$TB >6 & data$TB <=7.3, na.rm=TRUE)
#995
sum(data$TB >7.3 & data$TB <=8.5, na.rm=TRUE)
#681
sum(data$TB >8.5 & data$TB <=9.5, na.rm=TRUE)
#473
sum(data$TB >9.5, na.rm=TRUE)
#275
Trong đó, na.rm=TRUE là xóa các dòng có giá trị là N/A


########## Vẽ nhiều đường trên 1 đồ thị ##########
library("reshape2")
library("ggplot2")

dataTH <- read.table("F:/NTU/HoiThao/Khoa2021/draw_tonghop.csv",sep = ",",row.names = 1, header = TRUE)

datalineTH <- melt(dataTH, id = "Code")    # Transforming data to long format
head(datalineTH)                      # Printing head of long iris data

ggplot(datalineTH,                    # Drawing ggplot2 plot
       aes(x = Code,
           y = value,
           color = variable)) +
  geom_line(linetype="solid")+
  geom_point()

######### Vẽ cho các học kỳ ########
dataHK <- read.table("F:/NTU/HoiThao/Khoa2021/draw_hocky.csv",sep = ",",row.names = 1, header = TRUE)

dataHK <- melt(dataHK, id = "Code")    # Transforming data to long format
head(dataHK)                      # Printing head of long iris data

ggplot(dataHK,                    # Drawing ggplot2 plot
       aes(x = Code,
           y = value,
           color = variable)) +
  geom_line(aes(linetype=variable))+
  geom_point()+
  scale_linetype_manual(values=c("solid", "dashed", "dotted", "dotdash", "longdash", "twodash"))

Thêm ghi chú, nếu cần
  #Hoac
  #scale_linetype_manual(values=c("blank", "solid", "dashed", "dotted", "dotdash", "longdash", "twodash"))+
  #theme(legend.position="top")

The different line types available in R software are : “blank”, “solid”, “dashed”, “dotted”, “dotdash”, “longdash”, “twodash”.

###### Vẽ PCA cho phép phân cụm các khối ngành theo thang điểm
install.packages(c("FactoMineR", "factoextra"))
hoac:
>install.packages("FactoMineR")
>install.packages("factoextra")
#Nếu lỗi factoextra
>if(!require(devtools)) install.packages("devtools")
>devtools::install_github("kassambara/factoextra")

Load thư viện
> library("FactoMineR")
> library("factoextra")

datapca <- read.table("F:/NTU/HoiThao/Khoa2021/Data_PCA.csv",sep = ",",row.names = 1, header = TRUE)
res.pca <- PCA(datapca, graph = FALSE)
res.pca
eig.val <- get_eigenvalue(res.pca)
eig.val
fviz_eig(res.pca, addlabels = TRUE, ylim = c(0,7))
var <- get_pca_var(res.pca)
var

var$coord 
#(Correlation circle)
             Dim.1       Dim.2       Dim.3       Dim.4       Dim.5
Code_1  0.06169105  0.06075752  0.06624792  0.05655034  0.67473356
Code_2 -0.97232568 -0.19041093 -0.10147737 -0.05215165 -0.07229967
Code_3  0.56005395 -0.79090565 -0.20643105 -0.08884267 -0.10117293
Code_4  0.26247187  0.68582181 -0.64567136 -0.16166400 -0.13295530
Code_5  0.17605303  0.25788155  0.77289569 -0.52322723 -0.17698572
Code_6  0.14084049  0.17657291  0.29913285  0.89876117 -0.22736520
Code_7  0.06195041  0.06104602  0.06660962  0.05691118  0.69114282

var$cos2
#(Quality of representation)
             Dim.1       Dim.2       Dim.3       Dim.4       Dim.5
Code_1 0.003805785 0.003691476 0.004388787 0.003197940 0.455265374
Code_2 0.945417229 0.036256321 0.010297656 0.002719795 0.005227242
Code_3 0.313660423 0.625531746 0.042613780 0.007893020 0.010235961
Code_4 0.068891482 0.470351553 0.416891502 0.026135250 0.017677113
Code_5 0.030994669 0.066502895 0.597367755 0.273766737 0.031323945
Code_6 0.019836045 0.031177994 0.089480460 0.807771645 0.051694935
Code_7 0.003837853 0.003726616 0.004436841 0.003238882 0.477678392

fviz_pca_var(res.pca, col.var = "cos2",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
             repel = TRUE # Avoid text overlapping
             )

######Phaan cum bằng PCA
install.packages("devtools")
install_github("vqv/ggbiplot")
library(devtools)
library(ggbiplot)
str(datapca)
mtpca.pca <- prcomp(datapca, center = TRUE,scale. = TRUE)

mtpca.sample <- c(rep("Dulich",928),rep("Kinhte",792),rep("KTTC",585),rep("Ngoaingu",409),rep("CNTT",349),rep("Thucpham",251),rep("Oto",242),rep("Cokhi",205),rep("Dientu",129),rep("NTTS",112),rep("CNSH",69),rep("Xaydung",67),rep("Khaithac",34),rep("Tauthuy",24),rep("XHNV",25))
ggbiplot(mtpca.pca,ellipse=TRUE,  labels=rownames(datapca), groups=mtpca.sample)

