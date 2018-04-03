# DTI_codes
FSL DTI PROCESSING GUIDE
Kodlar ve pipeline ile ilgili sorular için iletişime geçebilirsiniz:
Özge Can Kaplan, ozgecankaplan@gmail.com, 0538 457 80 65

Kodlar şu işlere yarıyor: 

0.File-prep.sh : 
a. HC ve PD subjectler için çalışmak istediğimiz hastaların indexlerini giriyoruz. Daha önceden NAS&#39;a
yüklenmiş olan Bval, Bvec, DTI, B0 ve  T1 görüntülerini kodun kendisinin oluşturduğu DTI, T1 ve B0 adlı
klasörlere yüklüyor.

1.ECC_BET: 
a. Daha önceden indexleri girilmiş hastaların, B0 ve DTI görüntülerine eddy currentları düzeltir. ( outputlar,
inputların kayıtlı olduğu dosyalarda tutuluyor)
b. Daha önceden indexleri girilmiş hastaların B0 ve T1 görüntülerinde skull/spine extraction yapar. 
c. DTI / B0 / T1 verilerinin eddy current corrected ve skull/spine extracted hallerini NAS ta ki (sırasıyla)
DTI/B0/T1 dosyalarına yükler.

2.TENSOR_FITTING.sh : 
a.  Daha önceden indexleri girilmiş hastaların tensor_fitting işlemi gerçekleştiriliyor. FA MD çıkarılıyor ama
ilerde işlemler devam edecek.  burası için gerekli dosyalar zaten 0 nolu kodda a. basamağında indirilmişti. 

3. Register.sh 
a. Burada FA ve MD mapler ortak bir düzleme aktarılıyor.
Her hasta ve sağlıklı kontrol için şu işlemi yap:
i.B0_ecc_brain görüntüsünü MNI referans resmine ata. (flirt ile başlayan 1. Komut bu işi yapıyor)
ii.Tensor fitting sonucu çıkan FA haritasını (örn. PD10_fit_FA.nii.gz)  MNI haritasına register et. (flirt ile
başlayan 2. Komut) buradaki –applyxfm komutu, i. Adımda elde edilen transformatin matrisi ii. Adımda
uyguluyor.
iii. Tensor fitting sonucu çıkan MD haritasını (örn. PD10_fit_MD.nii.gz)  MNI haritasına register et. (flirt ile
başlayan 3. Komut) buradaki –applyxfm komutu, i. Adımda elde edilen transformatin matrisi iii. Adımda
uyguluyor.
 
b. Sonuçlar NAS&#39;a yüklendi. (NCFTPPUT)

4.TBSS 
 TBSS FA ve MD maplerle çalışan istatistiksel bir yöntem ve bir kaç aşamadan oluşuyor. Burada ben hasta
indexlerini yeniden girdiriyorum. Yine girilen hastaların FA ve MD mapleri NAStan indiriliyor. ve tbss stepleri
otomatik olarak ikilikarşılaştırmalar için dosyaları masaüstünde yine kendi açıyor. Bu kodun sonunda NAS&#39;a
herhangi bir yükleme yapmıyorum. Çünkü yeni bir hasta gelse bile bütün sonuçlar (gözle görünmese bile)
değişiyor. 

5.Stats
Karşılaştırma yapacağımız grubun tbss sonuçlarının olduğu klasöre gitmemiz gerekiyor. Cd komutu bu
yüzden var.
Design_ttest2 komutu design adında bir matris ve kontrast dosyası oluşturuyor.
Randomise komutu permütasyon testini yapıyor. Burada, n random permutation sayısını gösteriyor.
Tbss_fill komutu isteğe bağlı kullanılan bir komut. Randomise sonucu olan tbss_tfce_corrp_tstat1
dosyasının daha iyi görünebilmesi için istatistiksel anlamlı fark yaratan kısımları belirginleştiriyor.

6.Mask_Multiplier
Buradaki işlem, işlenmiş FA ve MD haritalarının, istenilen atlasın maskeleriyle çarpılması.
NOT1: Eğer registration kısmında MNI152_1mm görüntüsünü kullandıysanız, NAS üzerinden 1mm lik
maskeleri indirin ve bunlarla çarpma işlemi yapın. Eğer registration da 2mm lik template i kullandıysanız
2mm lik maskelerle işlem yapın. Aksi takdirde çarpma yapmaya kalktığınızda “inconsistent matrix
dimensions” hatası alacaksınız.

Atlas maskelerinin pc ye indirilmesinin ardından, kod şunu yapıyor:
Hasta listesindeki her hasta için:
1 den son maske indexine kadar, bütün maskeler için,
FA haritasını maske ile çarp.
MD haritasını maske ile çarp.
End.

Kontrol listesindeki her kişi için de aynı işlemi yap.
