import itertools
from traceback import print_tb
import numpy as np
from scipy import linalg
import matplotlib as mpl
import matplotlib.pyplot as plt

from sklearn import mixture



def plot_results(X, Y_, means, covariances, index, title, r=0, l=1):

    color_iter = itertools.cycle(["navy", "c", "cornflowerblue", "gold", "darkorange", "red", "green", "brown", "purple", "blue", "yellow", "pink", "black"])
    splot = plt.subplot(1, 1, 1 + index)
    for i, (mean, covar, color) in enumerate(zip(means, covariances, color_iter)):
        v, w = linalg.eigh(covar)
        v = 2.0 * np.sqrt(2.0) * np.sqrt(v)
        u = w[0] / linalg.norm(w[0])
        # as the DP will not use every component it has access to
        # unless it needs it, we shouldn't plot the redundant
        # components.
        if not np.any(Y_ == i):
            continue
        plt.scatter(X[Y_ == i, r], X[Y_ == i, l], 0.8, color=color)

        # Plot an ellipse to show the Gaussian component
        angle = np.arctan(u[1] / u[0])
        angle = 180.0 * angle / np.pi  # convert to degrees
        ell = mpl.patches.Ellipse(mean, v[0], v[1], 180.0 + angle, color=color)
        ell.set_clip_box(splot.bbox)
        ell.set_alpha(0.5)
        splot.add_artist(ell)

    # plt.xlim(-9.0, 5.0)
    # plt.ylim(-3.0, 6.0)
    # plt.xticks(())
    # plt.yticks(())
    plt.title(f'{title}: {r*13+l}')
    plt.savefig(f'./results/gmm_plot/{title}/{r*13+l}.png')
    # plt.show()
    plt.close("all")


if __name__ == "__main__":

    # Number of samples per component
    n_samples = 500

    # Generate random sample, two components
    np.random.seed(0)
    C = np.array([[0.0, -0.1], [1.7, 0.4]])
    X = np.r_[
        np.dot(np.random.randn(n_samples, 2), C),
        0.7 * np.random.randn(n_samples, 2) + np.array([-6, 3]),
    ]
    # Y = np.arange(0, 1000)
    print(X)

    # Fit a Gaussian mixture with EM using five components
    gmm = mixture.GaussianMixture(n_components=5, covariance_type="full").fit(X)
    print(gmm.predict(X))
    plot_results(X, gmm.predict(X), gmm.means_, gmm.covariances_, 0, "Gaussian Mixture")

    # Fit a Dirichlet process Gaussian mixture using five components
    dpgmm = mixture.BayesianGaussianMixture(n_components=5, covariance_type="full").fit(X)
    print("dome")
    # plot_results(
    #     X,
    #     dpgmm.predict(X),
    #     dpgmm.means_,
    #     dpgmm.covariances_,
    #     1,
    #     "Bayesian Gaussian Mixture with a Dirichlet process prior",
    # )

    plt.show()