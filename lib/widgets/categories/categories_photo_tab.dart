import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

final photos = [
  'https://s3-alpha-sig.figma.com/img/3ed7/a2d1/cb6ded0932c2b8c2846e5248f87c1b49?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=MBoIvEPNKZwCUvXzGrb7Ouux5KC-~mEQO~5lf6TPnLArlNdPDUbiyHMd~JiRkQjWlt0Srecwc7icQF-thpjvMOpkEQEBaqnq6QvSjBoDjOyVIvwH5uBwX8pMdo80z7wsM93KZfLy2nyTIAuxR4N1oCrdRrp7GcJLKEUoryTIwkjeBKP47N9LpYkhwFrHGpNt6cDmMCZmPlW4XE0GRKOcgj7nK0Lr1YtVkW8S5UjP7--b3vdCjXuUmWB6tDEhV7BSqW6t3k9Fq7~094RM56WbY10E0E~YKO3d20Ibivubzw2sLa~y11-rdTRsC21KwqkoVplEvTXEmly2Df~Ssl4sZA__',
  'https://s3-alpha-sig.figma.com/img/344a/e441/8392859fb193b51771d9e36cc9920c7d?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=O1qEXt3VHYf4d9WfUt2X7xiGEVQEszx1-fXH7Tvhb4dH8Egn2VqVcbhE7aYO-Iab4Ozf7x85KCguyJZ8OEoE2r3-VlfPyAmTDgJsqd-nhJ5HbCNFbUvIQgFrqymrsuscZosgQe7-kDZq9idtk7tH8VZ2dB0cUvXZojNulpezCCQfj7KxKGE~eeEm5gvzLZMcV4ey1U3wIUOjspmIkmf2ZRUzlITljO3bp6iOZqN6KnZSW9qf2g494F0RiEcXPw0kCEe~RFyTuKZtErvVIH6rQZ5zmeOnl8PAHGFyZqgY1NJKSHdFPjO0~7ukNbOReLJyUTYyqUB~bfdNj50KzUKsTw__',
  'https://s3-alpha-sig.figma.com/img/0f9b/5189/972e0e599c95e8f3561156d2ef04c8b4?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=HccbUVi1-pCUiumhM6TdkX1T18nLUVD8SVaH8APZ4NEdyVnphv7dtMa3UW6q3hSSg4v8Qdd4lTHC3lSkFHSVGTL1JjnsQd88HuFODX6slH1yWmVr1qmS-ENACQsUTo4-tluJMHGM113K2VQF7Hre2y1So0QZXh5KLcapmUB~XyEeY5EConMzZ7gRfub~L0gLND0wZwZf7uZB1YbXUiN262cTfPESqTXV62Z3rtmimfoHiJsZmSY2OPwLp0hKtkKU6zWewZx~s9n2iwP5XQBXKj6qkxINII5jyoVozydeF8PGD2vAiBxhtae4DxGYbF5JFcrr9EJ3dtEy4z-oQ~Ch5g__',
  'https://s3-alpha-sig.figma.com/img/d8ea/93bb/8676003f3db77220f8a1b02f12fc7cb7?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=uDEXkWRoNjUdy8Tp7Xhpvh8VFHaLGrYJK~gFK3Nxr2RF7DR-ABX1Y1wAdtnTwWCmunmg40GSBA~PpzVP-1Oey5MAkioeAps~POEoNAorjl85uvtY8fbX5qptAPn~Rd7XTlsGWsWLWEYDXQ0NhgDlXUa8PpDjP6mmBabbp5YN9BGHvxz5GOdYXZtIrr8oGUaINyXSj7aJaBTdcU1y2Nvn9qWJqkWDRSKgk-UkVQv2GH-7H3enyBKvX4UhJ99tDQnHMksLMQ0co6U73ilNQVCsc6U4dZ55zIHKhm-S-~7ejNH9p83v766-bW01dOStWqbVYZHK6a1jK1Gf8Rcchwi94A__'
];

class CategoriesPhotoTab extends StatelessWidget {
  const CategoriesPhotoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 164 / 154,
      ),
      itemCount: photos.length,
      itemBuilder: (ctx, index) => ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: photos[index],
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
