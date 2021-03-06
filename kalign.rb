class Kalign < Formula
  homepage "http://msa.sbc.su.se/"
  url "http://msa.sbc.su.se/downloads/kalign/kalign-2.04.tar.gz"
  sha256 "8cf20ac4e1807dc642e7ffba8f42a117313beccaee4f87c5555d53a2eeac4cbb"

  def install
    # Hard coded prefix:
    inreplace "Makefile.in", "/usr/local/bin/", "#{bin}/"
    mkdir_p bin

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    # Make sure kalign can to a simple fasta sequence alignment.
    input = <<-EOS.undent
      >E8S7Y8
      MNSPLTGTVALVAGATRGAGRQIAVQLGAAGATVYATGRTTRERRSEMDRPETIEETAELVTAAGGTGIAVAVDHLDPEQVRGLVERIDAEQGRL
      DVLVNDVWGADPLITWEKPVWEQPLDAGFRTLRLAVDTHIITSHFALPLLIRNPGGLVVEVGDGTKEHNDSEYRLSVFYDLAKVSVNRLGFSQAHELAPHGCTAVALTPG
      WLRSEAMLEHYGVTEANWRDAATTEPHFVMSETPAFVGRAVAALAADPDRARWNGQSLDSGGLSQVYGFTDVDGSRPHWARYYEEVVKPGKPADPDGYR
      >B1K8E8
      MATNLFDLTGKIALVTGASRGIGEEIAKLLAEQGAYVIVSSRKLDDCQAVADAIVAAGGRAEALACHVGRLEDIAATFEHIRGKHGRLDI
      LVNNAAANPYFGHILDTDLAAYEKTVDVNIRGYFFMSVEAGKLMKTHGGGAIVNTASVNALQPGDRQGIYSITKAAVVNMTKAFAKECGP
      LGIRVNALLPGLTKTKFAGALFADKDIYETWMTKIPLRRHAEPREMAGTVLYLVSDAASYTNGECIVVDGGLTI
    EOS
    output = `echo '#{input}' | #{bin}/kalign -f fasta 2>/dev/null`
    correct = <<-EOS.undent
      >E8S7Y8
      MNS---PLTGTVALVAGATRGAGRQIAVQLGAAGATVYATGRTTRERRSEMDRPETIEET
      AELVTAAGGTGIAVAVDHLDPEQVRGLVERIDAEQGRLDVLVNDVWGADPLITWEKPVWE
      QPLDAGFRTLRLAVDTHIITSHFALPLLIRNPGGLVVEVGDGTKEHNDSEYRLSV-----
      FYDLAKVSVNRLGFSQAHELAPHGCTAVALTPGWLRSE---AMLEHYGVTEANWRDAATT
      EPHFVMSETPAFVGRAVAALAADPDRARWNGQSLDSGGLSQVYGFTDVDGSRPHWARYYE
      EVVKPGKPADPDGYR
      >B1K8E8
      MATNLFDLTGKIALVTGASRGIGEEIAKLLAEQGAYVIVSSR----------KLDDCQAV
      ADAIVAAGGRAEALACHVGRLEDIAATFEHIRGKHGRLDILVNN--------AAANPYFG
      HILDTDLAAYEKTVDVN-IRGYFFMSV---EAGKLMKTHGGGAIVNTASVNALQPGDRQG
      IYSITKAAVVNMTKAFAKECGPLGIRVNALLPGLTKTKFAGALFADKDIYET-WMTKIPL
      RRH----AEPREMAGTVLYLVSDAASYTNGECIVVDGGLTI-------------------
      ---------------
    EOS
    output == correct
  end
end
